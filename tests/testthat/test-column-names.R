context("column-names")


col_names <- c("movie", "distributor", "gross",
               "percent_change", "theaters", "per_theater",
               "total_gross", "days", "date")
christmas <- as.Date(c("2012-12-25", "2013-12-25"))

test_that("columns have right names", {
  expect_named(boxoffice(), col_names)
  expect_named(boxoffice(top_n = 10), col_names)
  expect_named(boxoffice(site = "numbers"), col_names)
  expect_named(boxoffice(site = "numbers", top_n = 10), col_names)

  expect_named(boxoffice(dates = christmas), col_names)
  expect_named(boxoffice(dates = christmas, top_n = 10), col_names)
  expect_named(boxoffice(dates = christmas, site = "numbers"), col_names)
  expect_named(boxoffice(dates = christmas, site = "numbers", top_n = 10), col_names)
})



