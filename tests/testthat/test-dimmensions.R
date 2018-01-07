context("dimmensions")

test_that("returns proper number of rows and columns", {
  expect_equal(ncol(boxoffice()), 9)
  expect_equal(ncol(boxoffice(site = "numbers")), 9)

  expect_equal(dim(boxoffice(top_n = 10)), c(10, 9))
  expect_equal(dim(boxoffice(site = "numbers", top_n = 10)), c(10, 9))
})
