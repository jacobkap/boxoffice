
mojo_single_date <- function(date, number_of_results = NULL, verbose = FALSE){


  try(boxofficemojo <- read_html(paste("http://www.boxofficemojo.com/",
                                       "daily/chart/?view=1day&",
                                       "sortdate=", date,
                                       "&p=.htm", sep = "")))




  movie_name <- boxofficemojo %>% html_nodes("center a b") %>%
    html_text()
  movie_name <- data.frame(movie_name)


  if  (nrow(movie_name) < 1){
    return()
  }

  if (is.na(movie_name$movie_name[1])){
    return()
  }

  daily_gross <- boxofficemojo %>% html_nodes("center td font > b") %>%
    html_text()
  daily_gross <- data.frame(daily_gross)

  gross_to_date <- boxofficemojo %>% html_nodes("td:nth-child(10) font") %>%
    html_text()
  gross_to_date <- data.frame(gross_to_date)

  gross_per_theater <- boxofficemojo %>%
    html_nodes("tr+ tr td:nth-child(9) font") %>%
    html_text()
  gross_per_theater <- data.frame(gross_per_theater)
  gross_per_theater <- gross_per_theater[2:
                       length(gross_per_theater$gross_per_theater), ]
  gross_per_theater <- data.frame(gross_per_theater)

  if  (nrow(gross_per_theater) != nrow(movie_name) |
           nrow(gross_to_date) != nrow(movie_name)) {
    return()
             }

  box_storage <- cbind(movie_name, daily_gross)
  box_storage <- cbind(box_storage, gross_to_date)
  box_storage <- cbind(box_storage, gross_per_theater)
  box_storage$date <- ymd(date)

  if (!is.null(number_of_results)){
    box_storage <- box_storage[1:number_of_results, ]
  }

  if (verbose){
    message(paste(ymd(date), " completed", sep = ""))
  }


  return(box_storage)
}


# Scrapes date range from boxofficemojo.com
mojo_date_range <- function(start_date, end_date, number_of_results = NULL,
                            verbose = FALSE) {

  date_range <- seq(ymd(start_date),
                    ymd(end_date), by = "1 day")
  date_range <- data.frame(date_range)



  storage_final <- mojo_single_date(date_range$date_range[1],
                                    number_of_results,
                                    verbose = FALSE)

  if (verbose){
    message(paste(date_range$date_range[1], " ",
                  round((1 / nrow(date_range)) * 100, digits = 3),
                  "%",
                  " completed", sep = ""))
  }

  foreach(i = 2:nrow(date_range)) %do%{

    try(boxofficemojo <- read_html(paste("http://www.boxofficemojo.com/",
                                         "daily/chart/?view=1day&",
                                         "sortdate=", date_range$date_range[i],
                                         "&p=.htm", sep = "")))




    movie_name <- boxofficemojo %>% html_nodes("center a b") %>%
      html_text()
    movie_name <- data.frame(movie_name)


    if (nrow(movie_name) < 1){
      return()
    }

    if (is.na(movie_name$movie_name[1])){
      return()
    }

    daily_gross <- boxofficemojo %>% html_nodes("center td font > b") %>%
      html_text()
    daily_gross <- data.frame(daily_gross)

    gross_to_date <- boxofficemojo %>% html_nodes("td:nth-child(10) font") %>%
      html_text()
    gross_to_date <- data.frame(gross_to_date)

    gross_per_theater <- boxofficemojo %>%
      html_nodes("tr+ tr td:nth-child(9) font") %>%
      html_text()
    gross_per_theater <- data.frame(gross_per_theater)
    gross_per_theater <- gross_per_theater[2:
                      length(gross_per_theater$gross_per_theater), ]
    gross_per_theater <- data.frame(gross_per_theater)

    box_storage <- cbind(movie_name, daily_gross)
    box_storage <- cbind(box_storage, gross_to_date)
    box_storage <- cbind(box_storage, gross_per_theater)
    box_storage$date <- ymd(date_range$date_range[i])


    if (verbose){
      message(paste(date_range$date_range[i], " ",
                    round((i / nrow(date_range)) * 100, digits = 3),
                    "%",
                    " completed", sep = ""))
    }

    if (!is.null(number_of_results)){
      box_storage <- box_storage[1:number_of_results, ]
    }



    storage_final <- rbind(storage_final, box_storage)
}



  row.names(storage_final) <- 1:nrow(storage_final)
  return(storage_final)
}

# Scrapes multiple dates from boxofficemojo.com
mojo_multiple_dates <- function(dates, number_of_results = NULL,
                                verbose = FALSE) {
  dates <- ymd(dates)
  dates <- data.frame(dates)

  storage_final <- mojo_single_date(dates$dates[1],
                                    number_of_results,
                                    verbose)

  foreach(i = 2:nrow(dates)) %do%{

    try(boxofficemojo <- read_html(paste("http://www.boxofficemojo.com/",
                                         "daily/chart/?view=1day&",
                                         "sortdate=", dates$dates[i],
                                         "&p=.htm", sep = "")))




    movie_name <- boxofficemojo %>% html_nodes("td td font a b") %>%
      html_text()
    movie_name <- data.frame(movie_name)


    if (nrow(movie_name) < 1){
      return()
    }

    if (is.na(movie_name$movie_name[1])){
      return()
    }

    daily_gross <- boxofficemojo %>% html_nodes("center td font > b") %>%
      html_text()
    daily_gross <- data.frame(daily_gross)

    gross_to_date <- boxofficemojo %>% html_nodes("td:nth-child(10) font") %>%
      html_text()
    gross_to_date <- data.frame(gross_to_date)

    gross_per_theater <- boxofficemojo %>%
      html_nodes("tr+ tr td:nth-child(9) font") %>%
      html_text()
    gross_per_theater <- data.frame(gross_per_theater)
    gross_per_theater <- gross_per_theater[2:
                            length(gross_per_theater$gross_per_theater), ]
    gross_per_theater <- data.frame(gross_per_theater)

    box_storage <- cbind(movie_name, daily_gross)
    box_storage <- cbind(box_storage, gross_to_date)
    box_storage <- cbind(box_storage, gross_per_theater)
    box_storage$date <- ymd(dates$dates[i])

    if (!is.null(number_of_results)){
      box_storage <- box_storage[1:number_of_results, ]
    }



    if (verbose){
      message(paste(dates$dates[i], " ",
                    round((i / nrow(dates)) * 100, digits = 3),
                    "%",
                    " completed", sep = ""))
    }



    storage_final <- rbind(storage_final, box_storage)
    }


#  row.names(storage_final) <- 1:nrow(storage_final)
  return(storage_final)
}
