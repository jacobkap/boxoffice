context("column-values")

nums_ending_rows <- (nrow(christmas_num)-4):nrow(christmas_num)

test_that("proper dimmensions", {
  expect_equal(dim(christmas_mojo), c(59, 9))
  expect_equal(dim(christmas_num), c(44, 9))
})


test_that("numeric columns are accurate", {
  expect_equal(christmas_mojo$gross[c(1:5, 55:59)],
               c(27459557, 19138553,
                 6496365, 5604273,
                 2805466, 483, 177,
                 160, 141, 117))
  expect_equal(christmas_mojo$percent_change[c(1:5, 55:59)],
               c(55.8, 111.5, 146.7,
                 161.8, 112.6, NA,
                 NA, -35.5, NA, -25))
  expect_equal(christmas_mojo$theaters[c(1:5, 55:59)],
               c(4232, 3765, 3447,
                 3006, 2111, 8, 2,
                 1, 3, 1))
  expect_equal(christmas_mojo$per_theater[c(1:5, 55:59)],
               c(6488, 5083, 1884,
                 1864, 1328, 60, 88,
                 160, 47, 117))
  expect_equal(christmas_mojo$total_gross[c(1:5, 55:59)],
               c(395627411, 71913848,
                 26424890, 19008847,
                 164307743, 563231,
                 51772, 92117,
                 9238, 12620))
  expect_equal(christmas_mojo$days[c(1:5, 55:59)],
               c(11, 6, 4, 6, 34, 60,
                 69, 67, 11, 11))


  expect_equal(christmas_num$gross[c(1:5, nums_ending_rows)],
               c(27459557, 19138553,
                 6496365, 5604273,
                 2805466, 736, 602,
                 593, 160, 117))
  expect_equal(christmas_num$percent_change[c(1:5, nums_ending_rows)],
               c(56, 111, 147,
                 162, 113, 1, 3,
                 56, -35, -25))
  expect_equal(christmas_num$theaters[c(1:5, nums_ending_rows)],
               c(4232, 3765, 3447, 3006,
                 2111, 8, 8, 9, 1, 1))
  expect_equal(christmas_num$per_theater[c(1:5, nums_ending_rows)],
               c(6489, 5083, 1885,
                 1864, 1329, 92, 75,
                 66, 160, 117))
  expect_equal(christmas_num$total_gross[c(1:5, nums_ending_rows)],
               c(395627411, 71913848,
                 26424890, 19008847,
                 164307743, 7205484,
                 2289084, 127398,
                 92117, 12620))
  expect_equal(christmas_num$days[c(1:5, nums_ending_rows)],
               c(11, 6, 4, 6, 34, 60,
                 67, 46, 67, 11))
})

test_that("categorical columns are accurate", {
  expect_equal(christmas_mojo$movie[c(1:5, 55:59)],
               c("Star Wars: Episode VIII - The Last Jedi",
                 "Jumanji: Welcome to the Jungle",
                 "Pitch Perfect 3",
                 "The Greatest Showman",
                 "Coco",
                 "Novitiate",
                 "The Paris Opera",
                 "BPM (Beats Per Minute)",
                 "Permanent",
                 "Birdboy: The Forgotten Children"))
  expect_equal(christmas_mojo$distributor[c(1:5, 55:59)],
               c("Walt Disney Studios Motion Pictures",
                 "Sony Pictures Releasing",
                 "Universal Pictures",
                 "Fox",
                 "Walt Disney Studios Motion Pictures",
                 "Sony Pictures Classics",
                 "Film Movement",
                 "The Orchard",
                 "Magnolia Pictures",
                 "GKIDS"))

  expect_equal(christmas_num$movie[c(1:5, nums_ending_rows)],
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
  expect_equal(christmas_num$distributor[c(1:5, nums_ending_rows)],
               c("Walt Disney",
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
  expect_equal(unique(christmas_mojo$date), as.Date("2017-12-25"))
  expect_equal(unique(christmas_num$date), as.Date("2017-12-25"))
})
