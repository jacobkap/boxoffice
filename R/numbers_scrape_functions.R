
# Scrapes single date from the-numbers.com
numbers_single_date <- function(date, number_of_results = NULL,
                                verbose = FALSE){
  year <- year(ymd(date))
  month <- month(ymd(date))
  day <- day(ymd(date))

  numbers <- read_html(paste("http://www.the-numbers.com/box-office-chart/",
                             "daily/",
                             year,
                             "/",
                             month,
                             "/",
                             day,
                             sep = ""))


  movie_name <- numbers %>% html_nodes("#page_filling_chart b a") %>%
    html_text()
  movie_name <- data.frame(movie_name)

  if (nrow(movie_name) < 1){
    return()
  }

  daily_gross <- numbers %>% html_nodes(".data:nth-child(5)") %>%
    html_text()
  daily_gross <- data.frame(daily_gross)

  gross_to_date <- numbers %>% html_nodes(".chart_grey+ .data") %>%
    html_text()
  gross_to_date <- data.frame(gross_to_date)
  gross_to_date$gross_to_date <- gsub("..(.*)", "\\1",
                                      gross_to_date$gross_to_date)

  gross_per_theater <- numbers %>%
    html_nodes(".chart_grey") %>%
    html_text()
  gross_per_theater <- data.frame(gross_per_theater)




  if  (nrow(gross_per_theater) != nrow(movie_name) |
      nrow(gross_to_date != nrow(movie_name))) {
    box_storage <- mojo_single_date(date, number_of_results, verbose = FALSE)
  }
  else {
  box_storage <- cbind(movie_name, daily_gross)
  box_storage <- cbind(box_storage, gross_to_date)
  box_storage <- cbind(box_storage, gross_per_theater)
  box_storage$date <- ymd(date)
}

  if (!is.null(number_of_results)){
    box_storage <- box_storage[1:number_of_results, ]
  }

  if (verbose){
    message(paste(ymd(date), " completed", sep = ""))
  }


  return(box_storage)
}

numbers_date_range <- function(start_date, end_date, number_of_results = NULL,
                               verbose = FALSE){

  date_range <- seq(ymd(start_date),
                    ymd(end_date), by = "1 day")
  date_range <- data.frame(date_range)

  try(storage_final <- cleaner(numbers_single_date(date_range$date_range[1],
                                       number_of_results,
                                       verbose = FALSE)))

  if (verbose){
    message(paste(date_range$date_range[1], " ",
                  round((1 / nrow(date_range)) * 100, digits = 3),
                  "%",
                  " completed", sep = ""))
  }

  foreach(i = 2:nrow(date_range)) %do%{



 try(box_storage <- numbers_single_date(date_range$date_range[i],
                                  number_of_results,
                                  verbose = FALSE))
    storage_final <- rbind(storage_final, box_storage)

    if (verbose){
      message(paste(date_range$date_range[i], " ",
                    round((i / nrow(date_range)) * 100, digits = 3),
                    "%",
                    " completed", sep = ""))
    }
  }





  row.names(storage_final) <- 1:nrow(storage_final)
  return(storage_final)
}


numbers_multiple_dates <- function(dates, number_of_results = NULL,
                                   verbose = TRUE){


  dates <- data.frame(dates)

  storage_final <- cleaner(numbers_single_date(dates$dates[1],
                                               number_of_results,
                                       verbose))

  foreach(i = 2:nrow(dates)) %do%{


    box_storage <- numbers_single_date(dates$dates[i], number_of_results,
                                     verbose = FALSE)


    storage_final <- rbind(storage_final, box_storage)


    if (verbose){
      message(paste(dates$dates[i], " ",
                    round((i / nrow(dates)) * 100, digits = 3),
                    "%",
                    " completed", sep = ""))
    }


  }



  row.names(storage_final) <- 1:nrow(storage_final)
  return(storage_final)
}
