context("errors-silent")

test_that("returns silent", {
  expect_silent(boxoffice())
  expect_silent(boxoffice(top_n = 10))

  expect_silent(boxoffice(site = "numbers"))
  expect_silent(boxoffice(site = "numbers", top_n = 10))

})
