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
  # Removes everything but numbers and the negative sign,
  # then makes numeric.
  suppressWarnings(as.numeric(gsub("[^[:digit:]|\\-]", "", x)))
}

mojo_site <- function(page){
  page <- rvest::html_nodes(page, "center td tr+ tr td~ td+ td")
  page <- rvest::html_text(page)
  dim(page) <- c(9, length(page)/9)
  page <- t(page)
  page <- data.frame(page, stringsAsFactors = FALSE)

  names(page) <- c("movie", "distributor", "gross",
                   "percent_change", 'remove', "theaters",
                   "per_theater", "total_gross", "days")
  page$remove <- NULL
  return(page)
}

numbers_site <- function(page){
  page <- rvest::html_nodes(page, paste0("#page_filling_chart >",
                                           " center:nth-child(2) > table"))
  page <- rvest::html_table(page)
  page <- page[[1]]
  return(page)
}

