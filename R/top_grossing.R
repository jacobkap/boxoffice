
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
    final_data <- dplyr::bind_rows(final_data, temp)
  }

  final_data <- clean_top_grossing(final_data, ranks)

  message("Please note that these numbers are not adjusted for inflation.")
  return(final_data)
}


clean_top_grossing <- function(data, ranks) {
  data <-
    data %>%
    dplyr::rename(rank                     = Rank,
                  year_released            = Released,
                  movie                    = Movie,
                  american_box_office      = `DomesticBox Office`,
                  international_box_office = `InternationalBox Office`,
                  total_box_office         = `WorldwideBox Office`) %>%
    dplyr::mutate(rank                     = numeric_cleaner(rank),
                  year_released            = as.numeric(year_released),
                  american_box_office      = numeric_cleaner(american_box_office),
                  international_box_office = numeric_cleaner(international_box_office),
                  total_box_office         = numeric_cleaner(total_box_office)) %>%
    dplyr::filter(rank %in% ranks) %>%
    dplyr::select(rank,
                  movie,
                  year_released,
                  american_box_office,
                  international_box_office,
                  total_box_office)
  return(data)
}


get_rank_data <- function(url, page_number) {
  useragent <- paste0("Mozilla/5.0 (compatible; a bot using the R boxoffice",
                      " package; https://github.com/jacobkap/boxoffice/)")
  page <- httr::GET(paste0(url, page_number), httr::user_agent(useragent))
  page <- httr::content(page, "parsed", encoding = "UTF-8")
  page <- page %>% rvest::html_nodes("th , td") %>% rvest::html_text()
  dim(page) <- c(6, length(page) / 6)
  page <- t(page)
  page <- data.frame(page, stringsAsFactors = FALSE)

  names(page) <- page[1, ]
  page <- page[-1, ]
  return(page)
}
