# R for Data Science: Ch 4 Workflow: basics

# Note: don't use = instead of <-
# the assignment shortcut: Alt + -
x <- 3 + 4

# Note: use spaces to make code more readable!

# Object names:
# must start with a letter!
# can only contain letters, numbers, _, and .

# Note: the book recommends snake_case
# e.g. i_use_snake_case

this_is_a_really_long_name <- 2.5
this_is_a_really_long_name

# Note: in the console, Ctrl + [up] shows previous commands

r_rocks <- 2 ^ 3
r_rocks

# Note: start typing a function, then hit [tab] to autocomplete
# Note: while in the autocomplete window, hit F1 to access function help
seq(1,10)

x <- "hello world"

# Note: if a message in the console ends with "+" that means it's waiting for more
# Note: to get out of a partially completed command, hit [ESC]

y <- seq(1, 10, length.out=5)
y

# Note: surround assignment with () to print screen & assign
(y <- seq(1, 10, length.out=5))

# Exercises: 4.4
## 1. it appears that the code doesn't work because there is a typo
## however, it does run for me!
my_variable <- 10
my_variable

# 2. correcting code
library(tidyverse)

ggplot(data = mpg)+ # data, not dota
  geom_point(mapping = aes(x=displ, y=hwy))

filter(mpg, cyl == 8) # filter, not fliter; == not =

filter(diamonds, carat > 3) # diamonds, not diamond

# 3.
# Pressing Alt + Shift + K shows keyboard shortcuts!
# This can also be accessed in the menus using:
# Help -> Keyboard Shortcuts Help