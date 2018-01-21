context("column-values")

christmas <- boxoffice::boxoffice(dates = as.Date("2017-12-25"))
christmas_num <- boxoffice::boxoffice(dates = as.Date("2017-12-25"),
                                  site = "numbers")

test_that("proper dimmensions", {
  expect_equal(dim(christmas), c(59, 9))
  expect_equal(dim(christmas_num), c(43, 9))
})


test_that("numeric columns are accurate", {
  expect_equal(christmas$gross[c(1:5, 55:59)], c(27459557, 19138553,
                                                 6496365, 5604273,
                                                 2805466, 483, 177,
                                                 160, 141, 117))
  expect_equal(christmas$percent_change[c(1:5, 55:59)], c(56, 112, 147,
                                                          162, 113, NA,
                                                          NA, -36, NA, -25))
  expect_equal(christmas$theaters[c(1:5, 55:59)], c(4232, 3765, 3447,
                                                    3006, 2111, 8, 2,
                                                    1, 3, 1))
  expect_equal(christmas$per_theater[c(1:5, 55:59)], c(6489, 5083, 1885,
                                                       1864, 1329, 60, 89,
                                                       160, 47, 117))
  expect_equal(christmas$total_gross[c(1:5, 55:59)], c(395627411, 71913848,
                                                       26424890, 19008847,
                                                       164307743, 563231,
                                                       51772, 92117,
                                                       9238, 12620))
  expect_equal(christmas$days[c(1:5, 55:59)], c(11, 6, 4, 6, 34, 60,
                                                69, 67, 11, 11))


  expect_equal(christmas_num$gross[c(1:5, 39:43)], c(27459557, 19138553,
                                                     6496365, 5604273,
                                                     2805466, 736, 602,
                                                     593, 160, 117))
  expect_equal(christmas_num$percent_change[c(1:5, 39:43)], c(56, 111, 147,
                                                              162, 113, 1, 3,
                                                              56, -35, -25))
  expect_equal(christmas_num$theaters[c(1:5, 39:43)], c(4232, 3765, 3447, 3006,
                                                        2111, 8, 8, 9, 1, 1))
  expect_equal(christmas_num$per_theater[c(1:5, 39:43)], c(6489, 5083, 1885,
                                                           1864, 1329, 92, 75,
                                                           66, 160, 117))
  expect_equal(christmas_num$total_gross[c(1:5, 39:43)], c(395627411, 71913848,
                                                           26424890, 19008847,
                                                           164307743, 7205484,
                                                           2289084, 127398,
                                                           92117, 12620))
  expect_equal(christmas_num$days[c(1:5, 39:43)], c(11, 6, 4, 6, 34, 60,
                                                    67, 46, 67, 11))
})

test_that("categorical columns are accurate", {
  expect_equal(christmas$movie[c(1:5, 55:59)], c("Star Wars: The Last Jedi",
                                             "Jumanji: Welcome to the Jungle",
                                             "Pitch Perfect 3",
                                             "The Greatest Showman",
                                             "Coco",
                                             "Novitiate",
                                             "The Paris Opera",
                                             "BPM (Beats Per Minute)",
                                             "Permanent",
                                             "Birdboy: The Forgotten Children"))
  expect_equal(christmas$distributor[c(1:5, 55:59)], c("BV", "Sony", "Uni.",
                                                       "Fox", "BV", "SPC",
                                                       "FM", "Orch.", "Magn.",
                                                       "GK"))

  expect_equal(christmas_num$movie[c(1:5, 39:43)],
               c("Star Wars Ep. VIII: The Las…",
                 "Jumanji: Welcome to the Jungle",
                 "Pitch Perfect 3",
                 "The Greatest Showman",
                 "Coco",
                 "Let There Be Light",
                 "The Killing of a Sacred Deer",
                 "Thelma",
                 "BPM (Beats per Minute)",
                 "Birdboy: The Forgotten Chil…"))
  expect_equal(christmas_num$distributor[c(1:5, 39:43)], c("Walt Disney",
                                                       "Sony Pictures",
                                                       "Universal",
                                                       "20th Century Fox",
                                                       "Walt Disney",
                                                       "Atlas Distribution",
                                                       "A24",
                                                       "The Orchard",
                                                       "The Orchard",
                                                       "GKIDS"))
})


test_that("Date column is accurate", {
  expect_equal(unique(christmas$date), as.Date("2017-12-25"))
  expect_equal(unique(christmas_num$date), as.Date("2017-12-25"))
})
