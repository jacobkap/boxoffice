example               <- boxoffice::top_grossing()
example_international <- boxoffice::top_grossing(type = "international")
example_worldwide     <- boxoffice::top_grossing(type = "worldwide")

christmas <- as.Date(c("2012-12-25", "2013-12-25"))
christmas_impossible_dates <- as.Date(c("2012-12-25",
                                        "1800-12-25",
                                        "2013-12-25"))

christmas_num <- boxoffice::boxoffice(dates = as.Date("2017-12-25"))
christmas_impossible <- boxoffice::boxoffice(dates = as.Date(c("1800-12-25",
                                                               "2017-12-25")))
