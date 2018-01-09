context("dimmensions")

christmas <- as.Date(c("2012-12-25", "2013-12-25"))

test_that("returns proper number of rows and columns", {
  expect_equal(ncol(boxoffice(dates = as.Date("2017-12-25"))), 9)
  expect_equal(ncol(boxoffice(dates = as.Date("2017-12-25"),
                              site = "numbers")), 9)

  expect_equal(dim(boxoffice(dates = as.Date("2017-12-25"),
                             top_n = 10)), c(10, 9))
  expect_equal(dim(boxoffice(dates = as.Date("2017-12-25"),
                             site = "numbers", top_n = 10)), c(10, 9))

  expect_equal(ncol(boxoffice(dates = christmas)), 9)
  expect_equal(ncol(boxoffice(dates = christmas, site = "numbers")), 9)
  expect_equal(dim(boxoffice(dates = christmas, top_n = 10)), c(20, 9))
  expect_equal(dim(boxoffice(dates = christmas,
                             site = "numbers", top_n = 10)), c(20, 9))
})
