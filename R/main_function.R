#' Download Information on Box Office Results for Movies
#' @param dates
#' A vector of dates to scrape
#' @param top_n
#' The number of results to return for each day. If NULL (default) returns
#' all results, otherwise just top n  results (e.g. top_n = 5, returns 5 top
#' movies per date).
#' @return
#' Data frame returning info on the name of the movie, its daily gross,
#'  gross-to-date, and gross-per-theater for each date inputted.
#' @examples
#' boxoffice(dates = as.Date("2017-12-25"))
#'
#' # Returns only top 10 (daily) grossing movies
#' boxoffice(dates = as.Date("2017-12-25"), top_n = 10)
#' # Uses the dates of Christmas and New Years Eve 2017
#' boxoffice(dates = as.Date(c("2017-12-25", "2017-12-31")))
#'
#' @export
boxoffice <- function(dates,
                      top_n = NULL) {

  useragent <- paste0(
    "Mozilla/5.0 (compatible; a bot using the R boxoffice",
    " package; https://github.com/jacobkap/boxoffice/)")

  stopifnot(methods::is(dates, "Date") && is.atomic(dates))
  stopifnot(is.null(top_n) || is.numeric(top_n))

  if (any(dates >= (Sys.Date()))) {
    stop("Yesterday's data is the latest available. Please choose another date")
  }


  if ((!is.null(top_n) && length(top_n) != 1) ||
       (!is.null(top_n) && top_n <= 0) ) {
    stop("top_n must be a single, positive integer.")
  }


  url_start <- "https://www.the-numbers.com/box-office-chart/daily/"
  url_dates <- gsub("-", "/", dates)


  results <- vector("list", length = length(dates))

  for (i in seq_along(url_dates)) {

    page <- tryCatch({
      httr::GET(paste0(url_start, url_dates[i]),
                httr::user_agent(useragent))
    }, error = function(e) {
      message(paste0(url_start, url_dates[i],
                     " could not be scraped. Please check ",
                     "the website to make sure the date is available or ",
                     "check your internet connection."))
      return(NULL)
    })


    if (!is.null(page)) {
      page <- httr::content(page, "parsed", encoding = "UTF-8")
      page <- numbers_site(page)
      page <- fix_columns(page)

      # Makes numeric and removes $ and , values from columns -------------------
      page[, 3:ncol(page)]  <- sapply(page[3:ncol(page)], numeric_cleaner)

      if (!is.null(top_n)) {
        temp_top_n <- ifelse(top_n > nrow(page), nrow(page), top_n)
        page <- page[1:temp_top_n, ]
      }

      # If no error but no data found
      if (nrow(page) == 0 || nrow(page) == 1 & all(sapply(page, is.na))) {
        page <- NULL
        message(paste0("No results found for ", url_dates[i],
                       ". Please check the website to make ",
                       "sure that this date is available."))
      } else {
        page$date <- dates[i]
      }

      results[[i]] <- page
    }
  }

  # Faster to use data.table's rbindlist but don't want the dependency
  results <- do.call(rbind, results)
  results <- as.data.frame(results)

  if (nrow(results) == 0) {
    message(paste0("No results found. Please check the website to make ",
                   "sure the dates are available."))
    return(NULL)
  }
  return(results)

}

