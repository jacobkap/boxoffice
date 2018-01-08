context("column-values")

jan_6 <- boxoffice::boxoffice(dates = as.Date("2018-01-06"))
jan_6_num <- boxoffice::boxoffice(dates = as.Date("2018-01-06"),
                                  site = "numbers")

test_that("proper dimmensions", {
  expect_equal(dim(jan_6), c(32, 9))
  expect_equal(dim(jan_6_num), c(23, 9))
})


test_that("numeric columns are accurate", {
  expect_equal(jan_6$gross[c(1:5, 28:32)], c(15925000, 11026000, 10529000,
                                             4860000, 4448000, 26837,
                                             2604, 2301, 2074, 678))
  expect_equal(jan_6$percent_change[c(1:5, 28:32)], c(47, -13, 60, 16, 34,
                                                      78, 130, 50, 62, 70))
  expect_equal(jan_6$theaters[c(1:5, 28:32)], c(3801, 3116, 4232, 3342, 3458,
                                                37, 2, 41, 8, 5))
  expect_equal(jan_6$per_theater[c(1:5, 28:32)], c(4190, 3539, 2488, 1454, 1286,
                                                   725, 1302, 56, 259, 136))
  expect_equal(jan_6$total_gross[c(1:5, 28:32)], c(235107666, 23752000,
                                                   566075602, 72139372,
                                                   83538090, 5391630,
                                                   3735, 9479112, 136644,
                                                   93932))
  expect_equal(jan_6$days[c(1:5, 28:32)], c(18, 2, 23, 18, 16,
                                            93, 2, 86, 58, 79))

  expect_equal(jan_6_num$gross[c(1:5, 19:23)], c(15925000, 11026000, 10529000,
                                                 5860000, 4448000,
                                                 2604, 2301, 2074, 678, 18))
  expect_equal(jan_6_num$percent_change[c(1:5, 19:23)], c(47, -13, 60, 40, 33,
                                                          130, 50, 62, 70, -40))
  expect_equal(jan_6_num$theaters[c(1:5, 19:23)], c(3801, 3116, 4232, 3342,
                                                    3458, 2, 41, 8, 5, 2))
  expect_equal(jan_6_num$per_theater[c(1:5, 19:23)], c(4190, 3539, 2488, 1753,
                                                       1286, 1302, 56, 259,
                                                       136, 9))
  expect_equal(jan_6_num$total_gross[c(1:5, 19:23)], c(235107666, 23752000,
                                                       566075602, 73139372,
                                                       83538090, 3735,
                                                       9479112, 136644,
                                                       93932, 7212708))
  expect_equal(jan_6_num$days[c(1:5, 19:23)], c(30, 2, 23, 18, 16,
                                                2, 86, 58, 79, 72))
})

test_that("categorical columns are accurate", {
  expect_equal(jan_6$movie[c(1:5, 28:32)], c("Jumanji: Welcome to the Jungle",
                                             "Insidious: The Last Key",
                                             "Star Wars: The Last Jedi",
                                             "The Greatest Showman",
                                             "Pitch Perfect 3",
                                             "The Florida Project",
                                             "In Between",
                                             "Marshall",
                                             "Thelma",
                                             "BPM (Beats Per Minute)"))
  expect_equal(jan_6$distributor[c(1:5, 28:32)], c("Sony", "Uni.", "BV", "Fox",
                                                   "Uni.", "A24", "FM", "ORF",
                                                   "Orch.", "Orch."))

  expect_equal(jan_6_num$movie[c(1:5, 19:23)],
               c("Jumanji: Welcome to the Jungle",
                 "Insidious: The Last Key",
                 "Star Wars Ep. VIII: The Las…",
                 "The Greatest Showman",
                 "Pitch Perfect 3",
                 "In Between",
                 "Marshall",
                 "Thelma",
                 "BPM (Beats per Minute)",
                 "Let There Be Light"))
  expect_equal(jan_6_num$distributor[c(1:5, 19:23)], c("Sony Pictures",
                                                       "Universal",
                                                       "Walt Disney",
                                                       "20th Century Fox",
                                                       "Universal",
                                                       "Film Movement",
                                                       "Open Road",
                                                       "The Orchard",
                                                       "The Orchard",
                                                       "Atlas Distribution"))
})


test_that("Date column is accurate", {
  expect_equal(unique(jan_6$date), as.Date("2018-01-06"))
  expect_equal(unique(jan_6_num$date), as.Date("2018-01-06"))
})
