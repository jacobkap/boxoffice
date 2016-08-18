#' import lubridate
#' import foreach
#' import rvest

#' globalVariables("i")



#' Download Information on Box Office Results for Movies
#'
#' @param start_date
#' Enter the first date in the range, or the specific date
#' you want, or the list of dates you want. Dates must be in
#' year/month/date format.
#' @param end_date
#' If you use a date range, this will be your end date in the range (inclusive).
#' Dates must be in year/month/day format
#' @param number_of_results
#' How many results for each day (e.g. an input of 10 will return the top 10
#' movies that day)
#' @param source
#' Whether you want to get data from boxofficemojo.com or the-numbers.com.
#' @param verbose
#' Provides progress updates (which dates have been scraped and the
#' percent total done)
#'
#' @return
#' Data frame returning info on the name of the movie, its daily gross,
#'  gross-to-date, and gross-per-theater for each date inputted.
#' @export
#' @examples
#' # This will give you all movies from October 10th
#' # 2012 from the-numbers.com
#' boxoffice("12-10-10", source = "numbers")
#'
#' # This will do the same as above but from
#' # boxofficemojo.com. Each site has
#' # slightly differing results. Note that
#' # boxofficemojo is default
#' # and does not need to be manually inputted
#' \dontrun{boxoffice("12-10-10")}
#'
#' # Date range from October 10th - October 11th 2012
#' \dontrun{boxoffice("12-10-10", "12-10-11")}
#'
#' # Same as above, only grab top 10 movies
#' \dontrun{boxoffice("12-10-10", "12-10-11", number_of_results = 10)}
#'
#' # Same as above, with the-numbers.com as source
#' \dontrun{boxoffice("12-10-10", "12-10-11",
#' number_of_results = 10, source = "numbers")}
#'
#' # Multiple dates
#' \dontrun{boxoffice(c("12-10-10", "13-4-15"))}
#'
#' # Multiple dates with the-numbers as source
#' \dontrun{boxoffice(c("12-10-10", "13-4-15"), source = "numbers")}



boxoffice <- function(start_date,
                      end_date = NULL,
                      number_of_results = NULL,
                      source = "mojo",
                      verbose = FALSE) {


  if (source == "mojo"){
    if (is.null(end_date)){
      if (length(start_date) == 1){
        cleaner(mojo_single_date(start_date, number_of_results, verbose
        ))

      }
      else (cleaner(mojo_multiple_dates(start_date, number_of_results, verbose
                                       )))
    } else {
      if (!is.null(end_date)){


        cleaner(mojo_date_range(start_date, end_date, number_of_results, verbose
                                ))
      }
    }}

  else {
    if (source == "numbers"){
      if (is.null(end_date)){
        if (length(start_date) == 1){
          cleaner(numbers_single_date(start_date, number_of_results, verbose
                                      ))
        }
        else (cleaner(numbers_multiple_dates(start_date, number_of_results,
                                            verbose
                                            )))
      } else {
        if (!is.null(end_date)){


          cleaner(numbers_date_range(start_date, end_date, number_of_results,
                                     verbose
                                     ))
        }
      }}
  }
}


