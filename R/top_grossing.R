
#' Get the top N ranking grossing movies
#'
#' @param type
#' A string that says which type of box office you want. Options are
#' 'domestic' (American box office), 'international' (non-American) and
#' 'worldwide' (domestic + international box office).
#'
#' @param ranks
#' A vector of rankings based on ticket gross (e.g. Rank of 1 means
#' top selling movie, 2 is second top selling, etc.).
#'
#' @return
#' Data frame returning info on the name of the movie, it's rank,
#' the year the movie was released, and the total gross from
#' domestic (American), international, and total ticket sales.
#' @export
#'
#' @examples
#' top_grossing()
#'
#' top_grossing(ranks = 1:5)
#'
#' top_grossing(type = "international")
#' top_grossing(type = "international", ranks = 1:10)
top_grossing <- function(type = "american",
                         ranks = 1:100) {

  stopifnot(is.numeric(ranks) && is.character(type) && length(type) == 1)

  if (!type %in% c("american",
                   "international", "worldwide")) {
    stop(paste("type must be one of the following:",
               "'domestic' - Ranked by domestic gross (United States), all movies",
               "'internatonal' - Ranked by international gross, all movies",
               "'worldwide' - Ranked by worldwide gross (domestic + international), all movies",
               sep = "\n"))
  }

  if (min(ranks) < 1) {
    stop("ranks cannot be a number below 1")
  }


  if (type == "american") {
    type <- "domestic/all-movies"
  } else if (type == "international") {
    type <- "international/all-movies"
  } else if (type == "worldwide") {
    type <- "worldwide/all-movies"
  }
  url_start = paste0("https://www.the-numbers.com/box-office-records/",
                     type,
                     "/cumulative/all-time/")
  final_data  <- data.frame()
  page_numbers <- seq(min(ranks), max(ranks), 100)
  if (min(ranks) %% 100 == 0) {
    page_numbers <- c(page_numbers, max(ranks))
  }
  for (i in page_numbers) {
    temp       <- get_rank_data(url_start, i)
    final_data <- rbind(final_data, temp)
  }

  final_data <- clean_top_grossing(final_data, ranks)

  message("Please note that these numbers are not adjusted for inflation.")
  return(final_data)
}


clean_top_grossing <- function(data, ranks) {
  names(data) <- gsub(" ", "_", names(data))
  names(data) <- gsub("^Rank$",                    "rank", names(data))
  names(data) <- gsub("^Released$",                "year_released", names(data))
  names(data) <- gsub("^Movie$",                   "movie", names(data))
  names(data) <- gsub("^DomesticBox_Office$",      "american_box_office", names(data))
  names(data) <- gsub("^InternationalBox_Office$", "international_box_office", names(data))
  names(data) <- gsub("^WorldwideBox_Office$",     "total_box_office", names(data))
  data$rank                     <- numeric_cleaner(data$rank)
  data$year_released            <- numeric_cleaner(data$year_released)
  data$american_box_office      <- numeric_cleaner(data$american_box_office)
  data$international_box_office <- numeric_cleaner(data$international_box_office)
  data$total_box_office         <- numeric_cleaner(data$total_box_office)
  data <- data[data$rank %in% ranks, ]
  data <- data[, c("rank",
                   "movie",
                   "year_released",
                   "american_box_office",
                   "international_box_office",
                   "total_box_office")]
  return(data)
}


get_rank_data <- function(url, page_number) {
  useragent <- paste0("Mozilla/5.0 (compatible; a bot using the R boxoffice",
                      " package; https://github.com/jacobkap/boxoffice/)")
  page <- httr::GET(paste0(url, page_number), httr::user_agent(useragent))
  page <- httr::content(page, "parsed", encoding = "UTF-8")
  page <- rvest::html_nodes(page, "th , td")
  page <- rvest::html_text(page)
  dim(page) <- c(6, length(page) / 6)
  page <- t(page)
  page <- data.frame(page, stringsAsFactors = FALSE)

  names(page) <- page[1, ]
  page <- page[-1, ]
  return(page)
}
