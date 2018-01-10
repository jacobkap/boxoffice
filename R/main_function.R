#' Download Information on Box Office Results for Movies
#' @param dates
#' A vector of dates to scrape
#' @param site
#' Whether you want to get data from boxofficemojo.com or the-numbers.com.
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
#' # Uses the-numbers.com website.
#' boxoffice(dates = as.Date("2017-12-25"), site = "numbers")
#'
#' # Returns only top 10 (daily) grossing movies#'
#' boxoffice(dates = as.Date("2017-12-25"), top_n = 10)
#' # Uses the dates of Christmas and New Years Eve 2017
#' boxoffice(dates = as.Date(c("2017-12-25", "2017-12-31")))
#'
#' @export
boxoffice <- function(dates,
                      site = "mojo",
                      top_n = NULL) {

  stopifnot(length(site) == 1 && methods::is(dates, "Date") && is.atomic(dates))
  stopifnot(is.null(top_n) || is.numeric(top_n))

  if (any(dates >= (Sys.Date()))) {
    stop("Yesterday's data is latest available. Please choose another date")
  }

  if (!tolower(site) %in% c("mojo", "numbers")) {
    stop("site input must be either 'mojo' or 'numbers'")
  }

  if ( (!is.null(top_n) && length(top_n) != 1) ||
      (!is.null(top_n) && top_n <= 0) ) {
    stop("top_n must be a single, positive number.")
  }

  url_start <- "https://www.the-numbers.com/box-office-chart/daily/"
  if (site == "mojo") {
    url_start <- "http://www.boxofficemojo.com/daily/chart/?view=1day&sortdate="
  }

  results <- vector("list", length = length(dates))
  url_dates <- gsub("-", "/", dates)
  for (i in seq_along(url_dates)) {

    page <- NULL
    attempt <- 1
    while (is.null(page) && attempt <= 3 ) {
      Sys.sleep(0.3 * attempt)
      attempt <- attempt + 1
      try(
        page <- xml2::read_html(paste0(url_start, url_dates[i])),
      )
    }
    if (is.null(page)) {
      message(url_dates[i], "culd not be scraped.")
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
    stop("No results found. Please check dates inputted against website.")
  }

}
