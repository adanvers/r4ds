# R for Data Science 2e Chapter 10

library(tidyverse)


# 10.2 Aesthetic Mappings -------------------------------------------------

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, shape = class)) +
  geom_point()

# 1.
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "pink", shape = 17)
# 2.
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = "blue"))
# there are not blue points because the call to color is in aes.
# the call is asking for a color to be assigned to the attribute "blue"
# "blue" is an undefined category, so all points are given this color
# 3.
?geom_point
vignette("ggplot2-specs")
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(stroke = 0.5)
# the stroke aesthetic defines the "penstroke" of the point.
# the size can be changed by using a numeric value.
# 4.
# with an aesthetic mapped to a conditional, you create new a new categorical variable
# the new categorical can be used for further plotting
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = (displ < 5)))


# 10.3 Geometric Objects --------------------------------------------------

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_point(
    data = mpg |> filter(class == "2seater"),
    color = "red"
  ) +
  geom_point(
    data = mpg |> filter(class == "2seater"),
    shape = "circle open", size = 3, color = "red"
  )

library(ggridges)

ggplot(mpg, aes(x = hwy, y = drv, fill = drv, color = drv)) +
  geom_density_ridges(alpha = 0.5, show.legend = FALSE)

# 1.
# for line chart: geom_line()
# for boxplot: geom_boxplot()
# for histogram: geom_histogram()
# for area chart: geom_area()
# 2.
# show.legend determines if you want a key/legend
# 3.
# se adds a standard error ribbon to a smoother
# 4.


# 10.4 Facets -------------------------------------------------------------

# 1.
# faceting on a continuous variable turns it into a category
# 2.
# empty cells refer to cases with no points in them
ggplot(mpg) +
  geom_point(aes(x = drv, y = cyl))
# these results indicate there are no points at several combinations of cyl & drv
# 3.
# . is used to cross with no other factor (e.g., just one dimension)
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# 4.
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap( ~ class, nrow = 2)
# this faceting helps you to see more clearly which class has more points
# this faceting also helps you to pick out groups
# this might be more difficult to make comparisons. color overlap could help with some comparisons.
# 5.
?facet_wrap
# facet grid has a set number of rows & columns based on categories in the data
# 6.
ggplot(mpg, aes(x = displ)) +
  geom_histogram() +
  facet_grid(drv ~ .)
ggplot(mpg, aes(x = displ)) +
  geom_histogram() +
  facet_grid(. ~ drv)
# the first is easier to visualize.
# when you want to directly compare histogram bar heights, it's nice for them to line up.
# when you want to see differences in actual possible values, it's nice for the x-axis to line up.
# 7.
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(drv ~ ., nrow = 3)


# 10.5 Statistical Transformations ----------------------------------------

diamonds |>
  count(cut) |>
  ggplot(aes(x = cut, y = n)) +
  geom_bar(stat = "identity")

ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) +
  geom_bar()

ggplot(diamonds) +
  stat_summary(
    aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# 1.
# the default geom is "pointrange"
ggplot(diamonds, aes(x = cut, y = depth)) +
  geom_pointrange(stat = "summary",
                  fun.min = min,
                  fun.max = max,
                  fun = median)
# 2.
# geom_col will make a bar chart based on the value in the data
# geom_bar will bar heights proportional to cases in each group
# 3.
# list all geom / stat pairs
# 4.
# stat smooth computes using predictdf()
# stat smooth computes relations between two variables (x vs y usually)
# stat smooth can compute loess, lm, glm, gam
# 5.
# we set group = 1 because otherwise the group is x (cut)
ggplot(diamonds, aes(x = cut, y = after_stat(prop))) +
  geom_bar()
# in this plot, the group is the fill factor
ggplot(diamonds, aes(x = cut, fill = color, y = after_stat(prop))) +
  geom_bar()


# 10.6 Position Adjustments -----------------------------------------------

# 1.
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
# try jittering the points!
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_jitter()
# 2.
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(position = "identity")
# there is no difference! the default position for geom_point is identity.
# 3.
# jittering can be controlled by height and width
# 4.
# geom_jitter allows you to see lots of points in a scattered blob
# geom_count allows you to see a bigger blob the more points there are.
# geom_count is likely more useful in cases where there are unique categorical x vs y.
# 5.
ggplot(mpg) +
  geom_boxplot(aes(y = displ, group = hwy))
?geom_boxplot
# default position adjustment is "dodge2"


# 10.7 Coordinate Systems -------------------------------------------------

# 1.
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = factor(1), fill = clarity),
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  coord_polar(theta = "y")
# 2.
?coord_map
# coord_map projects spherical data from the earth onto the flat map.
# coord_quickmap does a simplified computation of this.
# 3.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()
# this shows that there is a close to linear relationship b/w city and highway gas mileage.
# however, we can see that the points are offset from the main diagonal.
# the offset indicates that hwy is consistently higher than city.


# 10.8 Layered Grammar of Graphics ----------------------------------------


