fix_columns <- function(data) {
  # Removes first 2 columns from numbers - that have empty column name
  data <- data[, names(data) != ""]

  # Makes column names lowercase and changes spaces to _
  names(data) <- tolower(names(data))
  names(data) <- gsub("\\s", "_", names(data))
  names(data) <- gsub("\\.", "", names(data))

  names(data) <- gsub("thtr", "theater", names(data))
  names(data) <- gsub("^change$", "percent_change", names(data))
  return(data)

}

numeric_cleaner <- function(x) {
  # Removes everything but numbers and the negative sign and the period,
  # then makes numeric.
  suppressWarnings(as.numeric(gsub("[^[:digit:]\\.\\-]", "", x)))
}

mojo_site <- function(page){
  page <- rvest::html_nodes(page, "td")
  page <- rvest::html_text(page)
  # Sometimes adds "-" followed by "false". Not sure why.
  falses <- grep("^false$", page)
  falses <- sort(c(falses, falses - 1))
  page <- page[-falses]
  dim(page) <- c(11, length(page) / 11)
  page <- t(page)
  page <- data.frame(page, stringsAsFactors = FALSE)
  page$X1 <- NULL
  page$X2 <- NULL

  names(page) <- c("movie",
                   "distributor",
                   "gross",
                   "percent_change",
                   "percent_change_week",
                   "theaters",
                   "per_theater",
                   "total_gross",
                   "days")
  page$percent_change_week <- NULL
  return(page)
}

numbers_site <- function(page){
  page <- rvest::html_nodes(page, paste0("#page_filling_chart >",
                                           " center:nth-child(2) > table"))
  page <- rvest::html_table(page)
  page <- page[[1]]
  return(page)
}

