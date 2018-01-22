[![Travis-CI Build
Status](https://travis-ci.org/jacobkap/boxoffice.svg?branch=master)](https://travis-ci.org/jacobkap/boxoffice)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/jacobkap/boxoffice?branch=master&svg=true)](https://ci.appveyor.com/project/jacobkap/boxoffice)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/boxoffice)](https://cran.r-project.org/package=boxoffice)

`boxoffice()` is a simple package to get information about daily box
office results of movies. It scrapes the webpages of either
<http://www.boxofficemojo.com> or <https://www.the-numbers.com/> for
this information. The data it returns are the following:

1.  Movie name  
2.  The studio that produced that movie  
3.  The daily gross  
4.  Daily percent change in gross  
5.  Number of theaters it is playing in  
6.  Average gross per theater (result of 4 / result of 5)
7.  Gross-to-date  
8.  How many days the movie has been playing  
9.  The date of the data

In essence, it shows how well each movie performed on a given day.

``` r
movies <- boxoffice::boxoffice(date = as.Date("2015-10-31"))
dim(movies)
```

    ## [1] 40  9

``` r
movies[1:5, ]
```

    ##                   movie distributor   gross percent_change theaters
    ## 1           The Martian         Fox 4564809             31     3218
    ## 2       Bridge of Spies          BV 3588796             45     2873
    ## 3            Goosebumps        Sony 3326075              9     3618
    ## 4 The Last Witch Hunter        LG/S 2023321             36     3082
    ## 5  Hotel Transylvania 2        Sony 1905762              7     2962
    ##   per_theater total_gross days       date
    ## 1        1419   179446657   30 2015-10-31
    ## 2        1249    43200132   16 2015-10-31
    ## 3         919    53277832   16 2015-10-31
    ## 4         656    17377961    9 2015-10-31
    ## 5         643   153858782   37 2015-10-31

There are three parameters for `boxoffice()`: `dates`, `site`, and
`top_n`.

`dates` are simply an input dates (in Date format) that you want to get
information on. In accepts either a single date or a vector of dates.
`site` indicates which site you want to scrape: the-numbers.com or
boxofficemojo.com. The accepted inptus are “mojo” which is the default
site or “numbers”. Both sites are very similar and provide nearly
identical results. All results are ordered in descending order by how
much that movie made on that day. For example, the top selling movie of
the day is the first value while the worst selling movie is the last
value.

Here is the first 10 movie names for both sites. We will use the `top_n`
parameter to only return the top 10 selling movies.

``` r
mojo <- boxoffice::boxoffice(dates = as.Date("2015-10-31"), 
                             site = "mojo", top_n = 10)
numbers <- boxoffice::boxoffice(dates = as.Date("2015-10-31"),
                             site = "numbers", top_n = 10)
cbind(mojo[, c(1,3)], numbers[, c(1,3)])
```

    ##                                       movie   gross
    ## 1                               The Martian 4564809
    ## 2                           Bridge of Spies 3588796
    ## 3                                Goosebumps 3326075
    ## 4                     The Last Witch Hunter 2023321
    ## 5                      Hotel Transylvania 2 1905762
    ## 6                                     Burnt 1733927
    ## 7  Paranormal Activity: The Ghost Dimension 1452089
    ## 8                              Crimson Peak 1393460
    ## 9                Our Brand Is Crisis (2015) 1260523
    ## 10                               Steve Jobs 1021780
    ##                           movie   gross
    ## 1                   The Martian 4564809
    ## 2               Bridge of Spies 3588796
    ## 3                    Goosebumps 3326075
    ## 4         The Last Witch Hunter 2023321
    ## 5          Hotel Transylvania 2 1905762
    ## 6                         Burnt 1733927
    ## 7  Paranormal Activity: The Gh… 1452089
    ## 8                  Crimson Peak 1393460
    ## 9           Our Brand is Crisis 1260523
    ## 10 The Met: Live in HD - Tannh… 1150000

The results are close. Some movie name spellings and numbers are
slightly different. In this case, the 10th ranking movie is also
different vetween the sites. Situations like this are rare. When looking
at more recent releases (e.g. within the last two weeks), there will be
more differences. These differences will disappear (at least for the
most part) as time goes on.
