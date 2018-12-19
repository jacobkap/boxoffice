[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/boxoffice)](https://cran.r-project.org/package=boxoffice.png)
[![Travis-CI Build
Status](https://travis-ci.org/jacobkap/boxoffice.svg?branch=master)](https://travis-ci.org/jacobkap/boxoffice)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/jacobkap/boxoffice?branch=master&svg=true)](https://ci.appveyor.com/project/jacobkap/boxoffice)
[![Coverage
status](https://codecov.io/gh/jacobkap/boxoffice/branch/master/graph/badge.svg)](https://codecov.io/github/jacobkap/boxoffice?branch=master)
[![](https://cranlogs.r-pkg.org/badges/boxoffice)](https://cran.rstudio.com/web/packages/boxoffice/index.html)

Overview
--------

The goal of `boxoffice` is to scrape movie data to get information about
daily box office results of movies and top grossing movies. It scrapes
the webpages of either <http://www.boxofficemojo.com> or
<https://www.the-numbers.com/> for this information.

Installation
------------

``` r
To install this package, use the code
install.packages("boxoffice")


# The development version is available on Github.
# install.packages("devtools")
devtools::install_github("jacobkap/boxoffice")
```

Overview
--------

The `boxoffice()` function gets daily boxoffice information. In essence,
it shows how well each movie performed on that day.

The data it returns are the following:

1.  Movie name  
2.  The studio that produced that movie  
3.  The daily gross  
4.  Daily percent change in gross  
5.  Number of theaters it is playing in  
6.  Average gross per theater (result of 4 / result of 5)
7.  Gross-to-date  
8.  How many days the movie has been in theaters  
9.  The date of the data

``` r
movies <- boxoffice::boxoffice(date = as.Date("2015-10-31"))
head(movies)
```

    ##                   movie      distributor   gross percent_change theaters
    ## 1           The Martian 20th Century Fox 4564809             31     3218
    ## 2       Bridge of Spies      Walt Disney 3588796             45     2873
    ## 3            Goosebumps    Sony Pictures 3326075              9     3618
    ## 4 The Last Witch Hunter        Lionsgate 2023321             36     3082
    ## 5  Hotel Transylvania 2    Sony Pictures 1905762              7     2962
    ## 6                 Burnt    Weinstein Co. 1733927             -5     3003
    ##   per_theater total_gross days       date
    ## 1        1419   179446657   30 2015-10-31
    ## 2        1249    43200132   16 2015-10-31
    ## 3         919    53277832   16 2015-10-31
    ## 4         656    17377961    9 2015-10-31
    ## 5         643   153858782   37 2015-10-31
    ## 6         577     3563747    2 2015-10-31

The `top_grossing()` function gets the

1.  Movie name
2.  Year released
3.  Total domestic (American market) sales
4.  Total international sales
5.  Total sales (domestic + international)

``` r
movies <- boxoffice::top_grossing()
```

    ## Please note that these numbers are not adjusted for inflation.

``` r
head(movies)
```

    ##   rank                                movie year_released
    ## 2    1 Star Wars Ep. VII: The Force Awakens          2015
    ## 3    2                               Avatar          2009
    ## 4    3                        Black Panther          2018
    ## 5    4               Avengers: Infinity War          2018
    ## 6    5                              Titanic          1997
    ## 7    6                       Jurassic World          2015
    ##   american_box_office international_box_office total_box_office
    ## 2           936662225               1116648995       2053311220
    ## 3           760507625               2015837654       2776345279
    ## 4           700059566                647011693       1347071259
    ## 5           678815482               1370000000       2048815482
    ## 6           659363944               1548844451       2208208395
    ## 7           652270625                996622583       1648893208
