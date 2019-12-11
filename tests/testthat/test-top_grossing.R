context("top_grossing")

# https://www.the-numbers.com/box-office-records/worldwide/all-movies/cumulative/all-time

test_that("wrong inputs cause error", {

  expect_error(top_grossing(ranks = "a"))
  expect_error(top_grossing(ranks = -1))
  expect_error(top_grossing(ranks = 0:10))
  expect_error(top_grossing(ranks = c("a", 1:5)))
  expect_error(top_grossing(type = "a"))
  expect_error(top_grossing(type = 1))
  expect_error(top_grossing(type = c("american", "international")))
  expect_error(top_grossing(type = "internationl"))
})

test_that("Correct number of rows and cols", {
  skip_on_cran()
  expect_equal(dim(top_grossing(ranks = 1:5)),              c(5, 6))
  expect_equal(dim(top_grossing()),                         c(100, 6))
  expect_equal(dim(top_grossing(ranks = 1:500)),            c(500, 6))
  expect_equal(dim(top_grossing(ranks = c(1:5, 7))),        c(6, 6))
  expect_equal(dim(top_grossing(ranks = c(1, 2, 3, 4, 5))), c(5, 6))
  expect_equal(dim(top_grossing(ranks = 1:125)),            c(125, 6))
  expect_equal(dim(top_grossing(ranks = 100:199)),          c(100, 6))
})

test_that("ranks are right", {
  skip_on_cran()
  expect_equal(top_grossing(ranks = 1:5)$rank,              1:5)
  expect_equal(top_grossing()$rank,                         1:100)
  expect_equal(top_grossing(ranks = 1:500)$rank,            1:500)
  expect_equal(top_grossing(ranks = c(1:5, 7))$rank,        c(1:5, 7))
  expect_equal(top_grossing(ranks = c(1, 2, 3, 4, 5))$rank, 1:5)
  expect_equal(top_grossing(ranks = 1:125)$rank,            1:125)
  expect_equal(top_grossing(ranks = 100:199)$rank,          100:199)
})

test_that("correct column names and type", {
  expect_named(example, c("rank",
                          "movie",
                          "year_released",
                          "american_box_office",
                          "international_box_office",
                          "total_box_office"))
  expect_type(example$rank, "double")
  expect_type(example$year_released, "double")
  expect_type(example$movie, "character")
  expect_type(example$american_box_office, "double")
  expect_type(example$international_box_office, "double")
  expect_type(example$total_box_office, "double")

  expect_named(example_international, c("rank",
                                        "movie",
                                        "year_released",
                                        "american_box_office",
                                        "international_box_office",
                                        "total_box_office"))
  expect_type(example_international$rank, "double")
  expect_type(example_international$year_released, "double")
  expect_type(example_international$movie, "character")
  expect_type(example_international$american_box_office, "double")
  expect_type(example_international$international_box_office, "double")
  expect_type(example_international$total_box_office, "double")

  expect_named(example_worldwide, c("rank",
                                    "movie",
                                    "year_released",
                                    "american_box_office",
                                    "international_box_office",
                                    "total_box_office"))
  expect_type(example_worldwide$rank, "double")
  expect_type(example_worldwide$year_released, "double")
  expect_type(example_worldwide$movie, "character")
  expect_type(example_worldwide$american_box_office, "double")
  expect_type(example_worldwide$international_box_office, "double")
  expect_type(example_worldwide$total_box_office, "double")
})


test_that("Domestic - top grossing columns have right values", {
  skip_on_cran()
  expect_equal(head(example$rank), 1:6)
  expect_equal(head(example$year_released), c(2015,
                                              2019,
                                              2009,
                                              2018,
                                              2018,
                                              1997))
  expect_equal(head(example$movie), c("Star Wars Ep. VII: The Force Awakens",
                                      "Avengers: Endgame",
                                      "Avatar",
                                      "Black Panther",
                                      "Avengers: Infinity War",
                                      "Titanic"))
  expect_equal(head(example$american_box_office), c(936662225,
                                                    858373000,
                                                    760507625,
                                                    700059566,
                                                    678815482,
                                                    659363944))
  expect_equal(head(example$international_box_office), c(1131561399,
                                                         1939427564,
                                                         2029197650,
                                                         646853595,
                                                         1369544272,
                                                         1548844451))
  expect_equal(head(example$total_box_office), c(2068223624,
                                                 2797800564,
                                                 2789705275,
                                                 1346913161,
                                                 2048359754,
                                                 2208208395))

})

test_that("International - top grossing columns have right values", {
  skip_on_cran()
  expect_equal(head(example_international$rank), 1:6)
  expect_equal(head(example_international$year_released), c(2009,
                                                            2019,
                                                            1997,
                                                            2018,
                                                            2015,
                                                            2015))
  expect_equal(head(example_international$movie),
               c("Avatar",
                 "Avengers: Endgame",
                 "Titanic",
                 "Avengers: Infinity War",
                 "Furious 7",
                 "Star Wars Ep. VII: The Force Awakens"))
  expect_equal(head(example_international$international_box_office),
               c(2029197650,
                 1939427564,
                 1548844451,
                 1369544272,
                 1165715774,
                 1131561399))
  expect_equal(head(example_international$american_box_office),
               c(760507625,
                 858373000 	,
                 659363944,
                 678815482,
                 353007020,
                 936662225))
  expect_equal(head(example_international$total_box_office),
               c(2789705275,
                 2797800564,
                 2208208395,
                 2048359754,
                 1518722794,
                 2068223624))

})

test_that("Worldwide - top grossing columns have right values", {
  skip_on_cran()
  expect_equal(head(example_worldwide$rank), 1:6)
  expect_equal(head(example_worldwide$year_released), c(2019,
                                                        2009,
                                                        1997,
                                                        2015,
                                                        2018,
                                                        2019))
  expect_equal(head(example_worldwide$movie),
               c("Avengers: Endgame",
                 "Avatar",
                 "Titanic",
                 "Star Wars Ep. VII: The Force Awakens",
                 "Avengers: Infinity War",
                 "The Lion King"))
  expect_equal(head(example_worldwide$total_box_office),
               c(2797800564,
                 2789705275,
                 2208208395,
                 2068223624,
                 2048359754,
                 1656313097))
  expect_equal(head(example_worldwide$american_box_office),
               c(858373000,
                 760507625,
                 659363944,
                 936662225,
                 678815482,
                 543638043))
  expect_equal(head(example_worldwide$international_box_office),
               c(1939427564,
                 2029197650,
                 1548844451,
                 1131561399,
                 1369544272,
                 1112675054))
})
