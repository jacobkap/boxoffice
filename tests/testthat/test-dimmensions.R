context("dimmensions")


test_that("returns proper number of rows and columns", {
  skip_on_cran()
  expect_equal(ncol(christmas_mojo), 9)
  expect_equal(ncol(christmas_num), 9)

  expect_equal(dim(boxoffice(dates = as.Date("2017-12-25"),
                             top_n = 10)), c(10, 9))

  expect_equal(ncol(boxoffice(dates = christmas, site = "mojo")), 9)
  expect_equal(dim(boxoffice(dates = christmas, top_n = 10)), c(20, 9))
  expect_equal(dim(boxoffice(dates = christmas,
                             site = "mojo", top_n = 10)), c(20, 9))
})
