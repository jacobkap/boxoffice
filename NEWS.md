# boxoffice 2.0.0

* Removes ability to scrape boxofficemojo.com as this site requires their written permission for scraping. 
  Removes the `site` parameter from `boxoffice()` as the only site is now the-numbers.com.
* Fail gracefully when a date cannot be scraped.

# boxoffice 1.3.0

* Fix package not working as boxofficemojo.com changed their site organization.

# boxoffice 1.2.3

* Fix tests due to site updating box office totals.

# boxoffice 1.2.2

* Fix tests due to site updating box office totals.

# boxoffice 1.2.0

* Adds ability to scrape top grossing movies - based on domestic (American), international, and total gross.
* Changes some tests as the website's top grossing page has been updated.

# boxoffice 1.1.0

* Adds message about boxofficemojo.com's scraping rules
    + i.e. ask them for permission!
* Change webscraping method to GET and include a user agent linking back to this package.
    + Thanks to GitHub user hrbrmstr for the suggestion!

# boxoffice 1.0.0

* Added a `NEWS.md` file to track changes to the package.    
* Simplified available parameters
* Minor speed increases


