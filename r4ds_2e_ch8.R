# R for Data Science 2e Chapter 8
library(tidyverse)


# 8.2 Reading Data from a File --------------------------------------------

students <- read_csv("https://pos.it/r4ds-students-csv")
students

students <- read_csv("https://pos.it/r4ds-students-csv",
                     na = c("N/A", ""))
students

students |> 
  janitor::clean_names() |>
  mutate(
    meal_plan = factor(meal_plan),
    age = parse_number(if_else(age == "five", "5", age))
    )

read_csv(
  "a, b, c
  1, 2, 3
  4, 5, 6"
)

# 1.
# if data were separated by | I would try read_delim, specifying that delimiter.
read_delim(
  "a | b | c
  1 | 2 | 3
  4 | 5 | 6"
)
# 2.
?read_csv
# basically everything but delim is the same
# 3.
?read_fwf
# most important arguments are col_positions
# 4.
read_csv(
  "x,y\n1,`a,b`",
  quote = "`"
)
# 5.
read_csv("a,b\n1,2,3\n4,5,6")
read_csv("a,b,c\n1,2\n1,2,3,4")
read_csv("a,b\n\"1")
read_csv("a,b\n1,2\na,b")
read_csv("a;b\n1;3")
problems()
# 6.
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying
annoying %>% select(`1`)
ggplot(annoying, aes(x = `1`, y = `2`)) +
  geom_point()
annoying |>
  mutate(`3` = `1` * `2`) |>
  rename(one = `1`, two = `2`, three = `3`)


# 8.3 Controlling column types --------------------------------------------


# 8.4 Reading data from multiple files ------------------------------------

sales_files <- c("data/01-sales.csv", "data/02-sales.csv", "data/03-sales.csv")
read_csv(sales_files, id = "file")

sales_files <- c("https://pos.it/r4ds-01-sales",
                 "https://pos.it/r4ds-02-sales",
                 "https://pos.it/r4ds-03-sales")
read_csv(sales_files, id = "file")


# 8.5 Writing to a file ---------------------------------------------------

write_csv(students, "students.csv")
read_csv("students.csv")

# use write_rds() and read_rds() for R data
write_rds(students, "students.rds")
read_rds("students.rds")

# arrow packages reads & writes parquet files
#install.packages("arrow")
library(arrow)
write_parquet(students, "students.parquet")
read_parquet("students.parquet")
# parquet is faster than RDS & is usable outside R


# 8.6 Data Entry ----------------------------------------------------------

tibble(
  x = c(1, 2, 5),
  y = c("h", "m", "g"),
  z = c(0.08, 0.83, 0.60)
)

tribble(
  ~x, ~y, ~z,
  "h", 1, 0.08,
  "m", 2, 0.83,
  "g", 5, 0.60,
)

