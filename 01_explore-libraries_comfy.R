#' Which libraries does R search for packages?

# try .libPaths(), .Library
.libPaths()
.Library

#' Installed packages

## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View() or similar to inspect
library(data.table)
Lib_table <- as.data.table(installed.packages())
View(Lib_table)

## how many packages?
dim(Lib_table)
nrow(Lib_table)

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
##   * what proportion need compilation?
##   * how break down re: version of R they were built on
Lib_table[,.N,by="LibPath"]
Lib_table[,.N,by="Priority"]
Lib_table[,.N,by="Built"]
Lib_table[,.N,by="NeedsCompilation"]
#table(Lib_table$Package,Lib_table$LibPath)
#table(Lib_table$Package,Lib_table$Priority)
table(Lib_table$NeedsCompilation)
Lib_table[,needs_com:= as.integer((Lib_table$NeedsCompilation=="yes"))]
#Lib_table[,prop:=]
summary(Lib_table$needs_com)


## for tidyverts, here are some useful patterns
install.packages("tidyverse")
install.packages("psych")
library(tidyverse)
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!
