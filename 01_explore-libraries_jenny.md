01\_explore-libraries\_jenny.R
================
subha
Wed Jan 31 14:08:27 2018

``` r
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

    ## [1] 158

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
    ## 4 C:/Users/subha/Documents/R/win-library/3.4 <NA>          128

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                  69 0.437 
    ## 2 yes                 83 0.525 
    ## 3 <NA>                 6 0.0380

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   Built     n    prop
    ##   <chr> <int>   <dbl>
    ## 1 3.4.1    14 0.0886 
    ## 2 3.4.2     1 0.00633
    ## 3 3.4.3   143 0.905

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
    ## 1 F         75 0.475
    ## 2 T         83 0.525
