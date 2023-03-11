# R for Data Science 2e

# making a reprex: minimal reproducible example
# you can use the reprex package to create reproducible examples
y <- 1:4
mean(y)
reprex::reprex()

# when you call reprex, it creates a reproducible example of the code you have copied on clipboard.
# reprex() output is formatted in markdown

tidyverse::tidyverse_update()

dput(mtcars)
mtcars <- reprex::reprex()

