#' Download Information on Box Office Results for Movies
#' @param dates
#' A vector of dates to scrape
#' @param site
#' Whether you want to get data from boxofficemojo.com or the-numbers.com.
#' Accepts inputs of "numbers" (default) or "mojo".
#' @param top_n
#' The number of results to return for each day. If NULL (default) returns
#' all results, otherwise just top n  results (e.g. top_n = 5, returns 5 top
#' movies per date).
#' @return
#' Data frame returning info on the name of the movie, its daily gross,
#'  gross-to-date, and gross-per-theater for each date inputted.
#' @examples
#' # Uses the-numbers.com website.
#' boxoffice(dates = as.Date("2017-12-25"))
#'
#' # Uses boxofficemojo.com website.
#' boxoffice(dates = as.Date("2017-12-25"), site = "mojo")
#'
#' # Returns only top 10 (daily) grossing movies
#' boxoffice(dates = as.Date("2017-12-25"), top_n = 10)
#' # Uses the dates of Christmas and New Years Eve 2017
#' boxoffice(dates = as.Date(c("2017-12-25", "2017-12-31")))
#'
#' @export
boxoffice <- function(dates,
                      site = c("mojo", "numbers"),
                      top_n = NULL) {

  useragent <- paste0(
    "Mozilla/5.0 (compatible; a bot using the R boxoffice",
                        " package; https://github.com/jacobkap/boxoffice/)")

  if (identical(site, c("mojo", "numbers"))) site <- "numbers"

  stopifnot(length(site) == 1 && methods::is(dates, "Date") && is.atomic(dates))
  stopifnot(is.null(top_n) || is.numeric(top_n))

  if (any(dates >= (Sys.Date()))) {
    stop("Yesterday's data is the latest available. Please choose another date")
  }

  if (!tolower(site) %in% c("mojo", "numbers")) {
    stop("site input must be either 'mojo' or 'numbers'")
  }

  if ( (!is.null(top_n) && length(top_n) != 1) ||
      (!is.null(top_n) && top_n <= 0) ) {
    stop("top_n must be a single, positive number.")
  }

  if (site == "mojo") {
    message(paste0("The terms of use for boxofficemojo.com does not permit scraping",
                   " without their written permission. If you do not have",
                   " written permission, please ask them for it or change the",
                   " site parameter to 'numbers' to use the-numbers.com which",
                   " does not forbid scraping without permission."))
  }

  url_start <- "https://www.the-numbers.com/box-office-chart/daily/"
  if (site == "mojo") {
    url_start <- "http://www.boxofficemojo.com/daily/chart/?view=1day&sortdate="
  }

  results <- vector("list", length = length(dates))
  url_dates <- gsub("-", "/", dates)
  for (i in seq_along(url_dates)) {

        page <- httr::GET(paste0(url_start, url_dates[i]), httr::user_agent(useragent))
        if (httr::http_error(page)) {
          Sys.sleep(0.5)
          page <- httr::GET(paste0(url_start, url_dates[i]), httr::user_agent(useragent))
        }
        if (httr::http_error(page)) {
          page <- NULL
        }

    page <- httr::content(page, "parsed", encoding = "UTF-8")
    if (is.null(page)) {
      message(url_dates[i], "could not be scraped. Please check the website to make sure the date is available or check your internet connection.")
    } else {
    if (tolower(site) == "mojo") {
      page <- mojo_site(page)
    } else {
      page <- numbers_site(page)
    }

    page <- fix_columns(page)

    # Makes numeric and removes $ and , values from columns -------------------
    page[, 3:ncol(page)]  <- sapply(page[3:ncol(page)], numeric_cleaner)
    page$date <- dates[i]

    if (!is.null(top_n)) {
      top_n <- ifelse(top_n > nrow(page), nrow(page), top_n)
      page <- page[1:top_n, ]
    }

    results[[i]] <- page
    }
  }

  # Faster to use data.table's rbindlist but don't want the dependency
  results <- do.call(rbind, results)
  results <- as.data.frame(results)

  if (nrow(results) > 0) {
  return(results)
  } else {
    stop("No results found. Please check the website to make sure the dates are available.")
  }

}
