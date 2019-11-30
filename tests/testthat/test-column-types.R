context("column_types")

col_types <- c("character",
               "character",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "numeric",
               "Date")



test_that("column types are correct", {

  expect_true(all(lapply(boxoffice(dates = as.Date("2017-12-25"),
                                   top_n = 10), class) == col_types))
  expect_true(all(lapply(boxoffice(dates = christmas), class) == col_types))
  expect_true(all(lapply(boxoffice(dates = christmas,
                                   top_n = 10), class) == col_types))


  expect_true(all(lapply(boxoffice(dates = christmas_impossible_dates),
                         class) == col_types))
  expect_true(all(lapply(boxoffice(dates = christmas_impossible_dates,
                                   top_n = 10), class) == col_types))

  expect_null(boxoffice(dates = as.Date("1200-12-25")))
  expect_null(boxoffice(dates = as.Date(c("1200-12-25",
                                          "1400-12-25"))))
})
