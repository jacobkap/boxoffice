context("column_types")

col_types <- c("character", "character", "numeric",
               "numeric", "numeric", "numeric",
               "numeric", "numeric", "Date")
christmas <- as.Date(c("2012-12-25", "2013-12-25"))

test_that("column types are correct", {
  expect_true(all(lapply(boxoffice(), class) == col_types))
  expect_true(all(lapply(boxoffice(site = "numbers"), class) == col_types))

  expect_true(all(lapply(boxoffice(top_n = 10), class) == col_types))
  expect_true(all(lapply(boxoffice(site = "numbers", top_n = 10), class) == col_types))


  expect_true(all(lapply(boxoffice(dates = christmas), class) == col_types))
  expect_true(all(lapply(boxoffice(dates = christmas, site = "numbers"), class) == col_types))

  expect_true(all(lapply(boxoffice(dates = christmas, top_n = 10), class) == col_types))
  expect_true(all(lapply(boxoffice(dates = christmas, site = "numbers", top_n = 10), class) == col_types))
})
