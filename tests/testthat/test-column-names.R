context("column-names")


col_names <- c("movie", "distributor", "gross",
               "percent_change", "theaters", "per_theater",
               "total_gross", "days", "date")

test_that("columns have right names", {
  expect_named(christmas_mojo, col_names)
  expect_named(christmas_num, col_names)
  expect_named(boxoffice(dates = as.Date("2017-12-25"), top_n = 10), col_names)

  expect_named(boxoffice(dates = christmas), col_names)
  expect_named(boxoffice(dates = christmas, top_n = 10), col_names)
  expect_named(boxoffice(dates = christmas, site = "mojo"), col_names)
  expect_named(boxoffice(dates = christmas, site = "mojo",
                         top_n = 10), col_names)
})
