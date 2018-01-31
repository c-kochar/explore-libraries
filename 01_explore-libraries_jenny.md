01\_explore-libraries\_jenny.R
================
subha
Wed Jan 31 14:40:51 2018

``` r
#created .md file
## how jenny might do this in a first exploration
## purposely leaving a few things to change later!
```

Which libraries does R search for packages?

``` r
.libPaths()
```

    ## [1] "C:/Users/subha/Documents/R/win-library/3.4"
    ## [2] "C:/Program Files/R/R-3.4.3/library"

``` r
## let's confirm the second element is, in fact, the default library
.Library
```

    ## [1] "C:/PROGRA~1/R/R-34~1.3/library"

``` r
#options(repos = c(CRAN = "https://cran.rstudio.com/"))
#install.packages("fs")
#install.packages("devtools")
library(fs)
path_real(.Library)
```

    ## C:/Program Files/R/R-3.4.3/library

Installed packages

``` r
library(tidyverse)
```

    ## -- Attaching packages -------------------------------------------------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 2.2.1     v purrr   0.2.4
    ## v tibble  1.4.2     v dplyr   0.7.4
    ## v tidyr   0.7.2     v stringr 1.2.0
    ## v readr   1.1.1     v forcats 0.2.0

    ## -- Conflicts ----------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

    ## [1] 164

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

    ## # A tibble: 4 x 3
    ##   LibPath                                    Priority        n
    ##   <chr>                                      <chr>       <int>
    ## 1 C:/Program Files/R/R-3.4.3/library         base           14
    ## 2 C:/Program Files/R/R-3.4.3/library         recommended    15
    ## 3 C:/Program Files/R/R-3.4.3/library         <NA>            1
    ## 4 C:/Users/subha/Documents/R/win-library/3.4 <NA>          134

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                  71 0.433 
    ## 2 yes                 87 0.530 
    ## 3 <NA>                 6 0.0366

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   Built     n    prop
    ##   <chr> <int>   <dbl>
    ## 1 3.4.1    16 0.0976 
    ## 2 3.4.2     1 0.00610
    ## 3 3.4.3   147 0.896

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ## [1] "translations"

``` r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n  prop
    ##   <lgl>  <int> <dbl>
    ## 1 F         79 0.482
    ## 2 T         85 0.518

``` r
devtools::session_info()
```

    ## Session info -------------------------------------------------------------

    ##  setting  value                       
    ##  version  R version 3.4.3 (2017-11-30)
    ##  system   x86_64, mingw32             
    ##  ui       RTerm                       
    ##  language (EN)                        
    ##  collate  English_United States.1252  
    ##  tz       America/Los_Angeles         
    ##  date     2018-01-31

    ## Packages -----------------------------------------------------------------

    ##  package    * version date       source        
    ##  assertthat   0.2.0   2017-04-11 CRAN (R 3.4.3)
    ##  backports    1.1.2   2017-12-13 CRAN (R 3.4.3)
    ##  base       * 3.4.3   2017-12-06 local         
    ##  bindr        0.1     2016-11-13 CRAN (R 3.4.3)
    ##  bindrcpp   * 0.2     2017-06-17 CRAN (R 3.4.3)
    ##  broom        0.4.3   2017-11-20 CRAN (R 3.4.3)
    ##  cellranger   1.1.0   2016-07-27 CRAN (R 3.4.3)
    ##  cli          1.0.0   2017-11-05 CRAN (R 3.4.3)
    ##  colorspace   1.3-2   2016-12-14 CRAN (R 3.4.3)
    ##  compiler     3.4.3   2017-12-06 local         
    ##  crayon       1.3.4   2017-09-16 CRAN (R 3.4.3)
    ##  datasets   * 3.4.3   2017-12-06 local         
    ##  devtools     1.13.4  2017-11-09 CRAN (R 3.4.3)
    ##  digest       0.6.14  2018-01-14 CRAN (R 3.4.3)
    ##  dplyr      * 0.7.4   2017-09-28 CRAN (R 3.4.3)
    ##  evaluate     0.10.1  2017-06-24 CRAN (R 3.4.3)
    ##  forcats    * 0.2.0   2017-01-23 CRAN (R 3.4.3)
    ##  foreign      0.8-69  2017-06-22 CRAN (R 3.4.3)
    ##  fs         * 1.1.0   2018-01-26 CRAN (R 3.4.3)
    ##  ggplot2    * 2.2.1   2016-12-30 CRAN (R 3.4.3)
    ##  glue         1.2.0   2017-10-29 CRAN (R 3.4.3)
    ##  graphics   * 3.4.3   2017-12-06 local         
    ##  grDevices  * 3.4.3   2017-12-06 local         
    ##  grid         3.4.3   2017-12-06 local         
    ##  gtable       0.2.0   2016-02-26 CRAN (R 3.4.3)
    ##  haven        1.1.1   2018-01-18 CRAN (R 3.4.3)
    ##  hms          0.4.1   2018-01-24 CRAN (R 3.4.3)
    ##  htmltools    0.3.6   2017-04-28 CRAN (R 3.4.3)
    ##  httr         1.3.1   2017-08-20 CRAN (R 3.4.3)
    ##  jsonlite     1.5     2017-06-01 CRAN (R 3.4.3)
    ##  knitr        1.18    2017-12-27 CRAN (R 3.4.3)
    ##  lattice      0.20-35 2017-03-25 CRAN (R 3.4.3)
    ##  lazyeval     0.2.1   2017-10-29 CRAN (R 3.4.3)
    ##  lubridate    1.7.1   2017-11-03 CRAN (R 3.4.3)
    ##  magrittr     1.5     2014-11-22 CRAN (R 3.4.3)
    ##  memoise      1.1.0   2017-04-21 CRAN (R 3.4.3)
    ##  methods    * 3.4.3   2017-12-06 local         
    ##  mnormt       1.5-5   2016-10-15 CRAN (R 3.4.1)
    ##  modelr       0.1.1   2017-07-24 CRAN (R 3.4.3)
    ##  munsell      0.4.3   2016-02-13 CRAN (R 3.4.3)
    ##  nlme         3.1-131 2017-02-06 CRAN (R 3.4.3)
    ##  parallel     3.4.3   2017-12-06 local         
    ##  pillar       1.1.0   2018-01-14 CRAN (R 3.4.3)
    ##  pkgconfig    2.0.1   2017-03-21 CRAN (R 3.4.3)
    ##  plyr         1.8.4   2016-06-08 CRAN (R 3.4.3)
    ##  psych        1.7.8   2017-09-09 CRAN (R 3.4.3)
    ##  purrr      * 0.2.4   2017-10-18 CRAN (R 3.4.3)
    ##  R6           2.2.2   2017-06-17 CRAN (R 3.4.3)
    ##  Rcpp         0.12.15 2018-01-20 CRAN (R 3.4.3)
    ##  readr      * 1.1.1   2017-05-16 CRAN (R 3.4.3)
    ##  readxl       1.0.0   2017-04-18 CRAN (R 3.4.3)
    ##  reshape2     1.4.3   2017-12-11 CRAN (R 3.4.3)
    ##  rlang        0.1.6   2017-12-21 CRAN (R 3.4.3)
    ##  rmarkdown    1.8     2017-11-17 CRAN (R 3.4.3)
    ##  rprojroot    1.3-2   2018-01-03 CRAN (R 3.4.3)
    ##  rstudioapi   0.7     2017-09-07 CRAN (R 3.4.3)
    ##  rvest        0.3.2   2016-06-17 CRAN (R 3.4.3)
    ##  scales       0.5.0   2017-08-24 CRAN (R 3.4.3)
    ##  stats      * 3.4.3   2017-12-06 local         
    ##  stringi      1.1.6   2017-11-17 CRAN (R 3.4.2)
    ##  stringr    * 1.2.0   2017-02-18 CRAN (R 3.4.3)
    ##  tibble     * 1.4.2   2018-01-22 CRAN (R 3.4.3)
    ##  tidyr      * 0.7.2   2017-10-16 CRAN (R 3.4.3)
    ##  tidyverse  * 1.2.1   2017-11-14 CRAN (R 3.4.3)
    ##  tools        3.4.3   2017-12-06 local         
    ##  utf8         1.1.3   2018-01-03 CRAN (R 3.4.3)
    ##  utils      * 3.4.3   2017-12-06 local         
    ##  withr        2.1.1   2017-12-19 CRAN (R 3.4.3)
    ##  xml2         1.2.0   2018-01-24 CRAN (R 3.4.3)
    ##  yaml         2.1.16  2017-12-12 CRAN (R 3.4.3)

``` r
#sessionInfo() 
```
