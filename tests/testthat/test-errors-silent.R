context("errors-silent")


test_that("returns silent", {
  expect_silent(boxoffice(dates = as.Date("2017-12-25")))
  expect_silent(boxoffice(dates = as.Date("2017-12-25"), top_n = 10))

  expect_silent(boxoffice(dates = christmas))
  expect_silent(boxoffice(dates = christmas, top_n = 10))


})

test_that("returns warning", {
  expect_message(boxoffice(dates = as.Date("2017-12-25"), site = "mojo"))
  expect_message(boxoffice(dates = as.Date("2017-12-25"), site = "mojo",
                          top_n = 10))

  expect_message(boxoffice(dates = christmas, site = "mojo"))
  expect_message(boxoffice(dates = christmas, site = "mojo", top_n = 10))
})


test_that("wrong inputs cause error - site", {
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = "moj"))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = ""))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = NULL))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = NA))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = 1))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = 1:10))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = "1:10"))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = boxoffice()))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), site = boxoffice))
})

test_that("wrong inputs cause error - top_n", {
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = c("string", 1)))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = 0))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = 1:10))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = -1))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = -1:5))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = c(5, 10)))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = "string"))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = boxoffice()))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = boxoffice))
  expect_error(boxoffice(dates = as.Date("2017-12-25"), top_n = NA))
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
  expect_error(boxoffice(dates = as.Date(Sys.Date())))
  expect_error(boxoffice(dates = as.Date("2025-01-01")))
  expect_error(boxoffice(dates = Sys.Date()))
  expect_error(boxoffice(dates = as.Date(c("2012-01-01",
                                           "2013-01-01", "2025-12-25"))))
  expect_error(boxoffice(dates = as.Date(c("2012-01-01",
                                           "2013-01-01", "2025-1"))))

})
