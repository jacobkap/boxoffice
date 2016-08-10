cleaner <- function(dataset){
  dataset$movie_name <- as.character(dataset$movie_name)

  # Removes commas
  dataset$daily_gross <- gsub(",", "", dataset$daily_gross)
  dataset$gross_per_theater <- gsub(",", "", dataset$gross_per_theater)
  dataset$gross_to_date <- gsub(",", "", dataset$gross_to_date)

  # Removes dollar signs
  dataset$daily_gross <- gsub("\\$", "", dataset$daily_gross)
  dataset$gross_per_theater <- gsub("\\$", "", dataset$gross_per_theater)
  dataset$gross_to_date <- gsub("\\$", "", dataset$gross_to_date)

  # Makes numeric
  dataset$daily_gross <- as.numeric(dataset$daily_gross)
  dataset$gross_per_theater <- as.numeric(dataset$gross_per_theater)
  dataset$gross_to_date <- as.numeric(dataset$gross_to_date)

  return(dataset)
}
