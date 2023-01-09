# R for Data Science Ch. 5

install.packages("nycflights13")

library(nycflights13)
library(tidyverse)

?flights

flights
# Note: flights is saved as a tibble

# Note: variable types are listed in the tibble
# int: integer
# dbl: doubles, aka real numbers
# chr: character vector, aka strings
# dttm: date-times
# lgl: logical
# fctr: factors, categorical data
# date: date

# Note: this chapter uses 5 key dplyr functions!
# filter(): pick observations
# arrange(): reorder rows
# select(): choose variables by name
# mutate(): create new variables
# summarize(): collapse many values to a summary

# Note: the 5 key functions can be used with group_by()
# group_by(): changes the scope of each function to be group-by-group

# Note: the verbs have 3 parts
# 1. first argument is a data frame
# 2. next arguments describe what to do with the data frame
# 3. the result is a data frame

filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)

(dec25 <- filter(flights, month == 12, day == 25))

filter(flights, month = 1)

sqrt(2) ^ 2 == 2
# these should be the same, but are not!
# thi is due to rounding / precision
1 / 49 * 49 == 1
# same issue! they should be the same, but are not!

near(sqrt(2) ^ 2, 2)
near(1 / 49 * 49, 1)
?near # for getting the help screen
near(sqrt(2) ^ 2, 2.000001) # this is false!
# the tolerance is the machine tolerance

filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))

# flights not delayed (on arrival or departure) by more than 2 hours
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# Missing values:
NA > 5
10 == NA
NA + 10
NA / 2
NA == NA
is.na(NA)

# Note: filter excludes both FALSE and NA values
# you can ask for NA values explicitly
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# Exercises 5.2.4
# 1. find all flights!
# a. arrival delay of 2 or more hours
filter(flights, arr_delay >= 120)
# b. flew to Houston (IAH or HOU)
?flights
filter(flights, dest %in% c("IAH", "HOU"))
# c. operated by United, American, or Delta
?airlines
table(flights$carrier)
airlines
filter(flights, carrier %in% c("UA", "AA", "DL"))
# d. departed in summer (July, August, September)
filter(flights, month %in% 7:9)
# e. arrived more than 2 hours late, but didn't leave late
filter(flights, arr_delay > 120 & dep_delay == 0)
# f. delayed by at least an hour, but made up over 30 min in flight
filter(flights, dep_delay >= 60 & arr_delay < 30)
# g. departed between midnight and 6 am
range(flights$dep_time, na.rm=T)
filter(flights, dep_time >= 0 & dep_time <= 600)
# 2. between()
?between
# used to identify values in a variable between two boundaries
filter(flights, between(dep_time, 0, 600))
filter(flights, between(month, 7, 9))
# 3.
# how many flights have a missing dep_time
nrow(filter(flights, is.na(dep_time)))
# what other variables are missing
(no_dep <- filter(flights, is.na(dep_time)))
# dep_delay and arr_time are missing!
# these might represent flights that never left
# 4.
NA ^ 0
# any number raised to the 0 power is 1
NA | TRUE
# any value or TRUE is TRUE
FALSE & NA
# any value AND FALSE is FALSE
NA * 0
# any value times 0 should be 0...
# what is the general rule?

