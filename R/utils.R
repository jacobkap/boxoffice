fix_columns <- function(data) {
  # Removes first 2 columns from numbers - that have empty column name
  data <- data[, names(data) != ""]
  # Removes the % change from last week to stay consistent in old column order.
  data$`%LW` <- NULL

  names(data) <- c("movie",
                   "distributor",
                   "gross",
                   "percent_change",
                   "theaters",
                   "per_theater",
                   "total_gross",
                   "days")

  # Fixes strange ... when runs out of space to ... that is readable to R.
  data$movie       <- iconv(data$movie, "latin1", "ASCII", sub = "")
  data$distributor <- iconv(data$distributor, "latin1", "ASCII", sub = "")

  # names(data) <- gsub("thtr", "theater", names(data))
  # names(data) <- gsub("^change$", "percent_change", names(data))
  return(data)

}

numeric_cleaner <- function(x) {
  # Removes everything but numbers and the negative sign and the period,
  # then makes numeric.
  suppressWarnings(as.numeric(gsub("[^[:digit:]\\.\\-]", "", x)))
}

numbers_site <- function(page){
  page <- rvest::html_nodes(page, paste0("#box_office_table"))
  page <- rvest::html_table(page)
  page <- page[[1]]

  # Last 2 rows are blank, removes the
  page <- page[1:(nrow(page) - 2), ]

  return(page)
}

