library(usethis)
use_data_raw()
use_readme_rmd()
use_mit_license("CC0")

library(desc)

unlink("DESCRIPTION")

my_desc <- description$new("!new")
my_desc$set("Package", "vinnova")
my_desc$set("Authors@R", "person('Markus', 'Skyttner', email = 'markussk@kth.se', role = c('cre', 'aut'))")

my_desc$del("Maintainer")

my_desc$set_version("0.0.0.9000")

my_desc$set(Title = "Vinnova - Open Data From The Swedish Innovation Agency")
my_desc$set(Description = "Vinnova provides open data about programmes, calls for proposals and application rounds as well as projects that have been funded. This R package uses the open APIs at Vinnova to make data available for use from R.")
my_desc$set("URL", "https://github.com/KTH-Library/vinnova")
my_desc$set("BugReports", "https://github.com/KTH-Library/vinnova/issues")
my_desc$set("License", "MIT")
my_desc$write(file = "DESCRIPTION")

#use_mit_license(name = "Markus Skyttner")
#use_code_of_conduct()
use_news_md()
use_lifecycle_badge("Experimental")

use_tidy_description()

use_testthat()
#use_vignette("swecris")

use_package("purrr")
use_package("dplyr")
use_package("jsonlite")
use_package("httr")
use_package("lubridate")

use_roxygen_md()
use_pkgdown_github_pages()

document()
test()
check()
pkgdown::build_site()

use_github()
use_github_actions()

non_ascii_fixer <- function(x) {
  has_non_ascii <- length(tools::showNonASCII(x)) > 0
  if (has_non_ascii) {
    message("Fix to:")
    return(cat(stringi::stri_escape_unicode(x)))
  }
  x
}

non_ascii_fixer("Kungliga tekniska högskolan")
stringi::stri_escape_unicode("➛")
