context("errors-silent")

christmas <- as.Date(c("2012-12-25", "2013-12-25"))

test_that("returns silent", {
  expect_silent(boxoffice())
  expect_silent(boxoffice(top_n = 10))

  expect_silent(boxoffice(site = "numbers"))
  expect_silent(boxoffice(site = "numbers", top_n = 10))

  expect_silent(boxoffice(dates = christmas))
  expect_silent(boxoffice(dates = christmas, top_n = 10))

  expect_silent(boxoffice(dates = christmas, site = "numbers"))
  expect_silent(boxoffice(dates = christmas, site = "numbers", top_n = 10))

})


test_that("wrong inputs cause error - site", {
  expect_error(boxoffice(site = "moj"))
  expect_error(boxoffice(site = ""))
  expect_error(boxoffice(site = NULL))
  expect_error(boxoffice(site = NA))
  expect_error(boxoffice(site = 1))
  expect_error(boxoffice(site = 1:10))
  expect_error(boxoffice(site = "1:10"))
  expect_error(boxoffice(site = boxoffice()))
  expect_error(boxoffice(site = boxoffice))
  expect_error(boxoffice(site = c("mojo", "numbers")))
})

test_that("wrong inputs cause error - top_n", {
  expect_error(boxoffice(top_n = c("string", 1)))
  expect_error(boxoffice(top_n = 0))
  expect_error(boxoffice(top_n = 1:10))
  expect_error(boxoffice(top_n = -1))
  expect_error(boxoffice(top_n = -1:5))
  expect_error(boxoffice(top_n = c(5, 10)))
  expect_error(boxoffice(top_n = "string"))
  expect_error(boxoffice(top_n = boxoffice()))
  expect_error(boxoffice(top_n = boxoffice))
  expect_error(boxoffice(top_n = NA))
})


test_that("wrong inputs cause error - dates", {
  expect_error(boxoffice(dates = c("string", 1)))
  expect_error(boxoffice(dates = boxoffice()))
  expect_error(boxoffice(dates = boxoffice))
  expect_error(boxoffice(dates = NULL))
  expect_error(boxoffice(dates = NA))
  expect_error(boxoffice(dates = 0))
  expect_error(boxoffice(dates = "2012-12-25"))
  expect_error(boxoffice(dates = c(10, as.Date(c("2012-01-01")))))
  expect_error(boxoffice(dates = Sys.Date()))
  expect_error(boxoffice(dates = as.Date(c("2012-01-01",
                                           "2013-01-01", "2025-12-25"))))
  expect_error(boxoffice(dates = as.Date(c("2012-01-01",
                                           "2013-01-01", "2025-1"))))

})
