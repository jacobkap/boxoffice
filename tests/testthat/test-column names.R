context("column-names")


col_names <- c("movie", "distributor", "gross",
               "percent_change", "theaters", "per_theater",
               "total_gross", "days", "date")

test_that("columns have right names", {
  expect_named(boxoffice(), col_names)
  expect_named(boxoffice(top_n = 10), col_names)
  expect_named(boxoffice(site = "numbers"), col_names)
  expect_named(boxoffice(site = "numbers", top_n = 10), col_names)
})
