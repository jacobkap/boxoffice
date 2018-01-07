context("column_types")

col_types <- c("character", "character", "numeric",
               "numeric", "numeric", "numeric",
               "numeric", "numeric", "Date")

test_that("column types are correct", {
  expect_true(all(lapply(boxoffice(), class) == col_types))
  expect_true(all(lapply(boxoffice(site = "numbers"), class) == col_types))

  expect_true(all(lapply(boxoffice(top_n = 10), class) == col_types))
  expect_true(all(lapply(boxoffice(site = "numbers", top_n = 10), class) == col_types))
})
