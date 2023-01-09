### Working through R4DS ###

# Visualization Chapter
library(tidyverse)

mpg
# noted: mpg automatically loads with ggplot
# ?mpg for learning about mpg

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))
# displ: engine size (technically engine displacement)
# hwy: fuel efficiency

# 3.2.4 Exercises
# 1.
ggplot(data=mpg)
# I see nothing! there's no geom_function
# 2.
dim(mpg)
# rows: 234, cols: 11
# 3.
?mpg
# type of drive train:
# f = front-wheel drive
# r = rear-wheel drive
# 4 = 4 wheel drive
# 4.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=hwy, y=cyl))
# 5.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=class, y=drv))
# the problem with this plot is that it seems like some points are on top of each other. We can't tell how often certain combinations occur.
# it might be easier to understand this data using a table:
table(mpg$class, mpg$drv)

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, color=class))

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, size=class))

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, shape=class))
# having more than 6 types, the 7th one just isn't plotted!

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy), color="blue")

# 3.3.1 Exercises
# 1.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, color="blue"))
# in the code above, the color is *in aes*
# this code creates a one-category label, called "blue"
# 2.
glimpse(mpg)
# categorical: manufacturer, model, trans, drv, fl, class
# continuous: displ, year, cyl, cty, hwy
# 3.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, color=cty))
# the continuous variable automatically creates a gradient shading corresponding to the score
# 4.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, color=hwy, size=hwy))
# there's no error when the same variable is mapped to multiple aesthetics
# you can get two legends for different aes mappings
# 5.
?geom_point
vignette("ggplot2-specs")
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy), stroke=1.2, fill="blue", shape=22)
# the stroke aes is the outline of the shape
# the stroke aes only works with point shapes that have an outline
# it seems like all the points have a stroke aes?
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy), stroke=1.2, shape=4)
# 6.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, color=displ < 5))
# you can use a logical argument, like displ < 5, to create categories in an aes

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_wrap(~ class, nrow=2)

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(drv ~ cyl)

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(. ~ drv)

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(drv ~ .)

# 3.5.1 Exercises
# 1.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_wrap(~ year)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_wrap(~ cty)
# if you use a continuous variable in a facet statement, it treats the variable as a category
# 2.
ggplot(data=mpg)+
  geom_point(mapping = aes(x=drv, y=cyl))
# the empty cells indicate no data
# they correspond to the places in the drv vs cyl plot with no points
# 3.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(drv~.)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(.~drv)
# where the . is in the facet statement indicates which way the facets go
# start with a . means panel rows
# end with a . means panel cols
# 4.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_wrap(~ class, nrow=2)
# in this data, the facet aes allows us to separate out the groups more cleanly.
# it's easier to see the different groups this way.
# the color allowed us to pick out the group of 2-seaters in the earlier plot.
# if there were more groups, it would be harder to use facet--it would be too cluttered.
# if there were just more points from the same groups, I'd probably still prefer a facet.
# 5.
?facet_wrap
# nrow specifies the number of panel rows
# ncol specifies the number of panel columns
# facet_grid doesn't have nrow & ncol because both those values are meant to be specified
# facet_grid is meant for cases when there are two discrete variables to be used in paneling.
# 6.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(class~drv)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  facet_grid(drv~class)
# I don't see a strong reason to go with more rows vs. more columns
# I guess more rows creates some distortion in the plot that can be harder to read
# compressing the y-axis (relative to x) might be worse in some cases

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))

ggplot(data=mpg)+
  geom_smooth(mapping=aes(x=displ, y=hwy))

ggplot(data=mpg)+
  geom_smooth(mapping=aes(x=displ, y=hwy, linetype=drv))

ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv))+
  geom_point()+
  geom_smooth()

ggplot(data=mpg)+
  geom_smooth(
    mapping = aes(x=displ, y=hwy, color=drv),
    show.legend=FALSE
  )

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy))+
  geom_smooth(mapping=aes(x=displ, y=hwy))

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth()

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(mapping=aes(color=class))+
  geom_smooth()

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(mapping=aes(color=class))+
  geom_smooth(data=filter(mpg, class=="subcompact"), se=FALSE)

# 3.6.1 Exercises
# 1.
?geom_line
?geom_boxplot
?geom_histogram
?geom_area
# there are geoms for each of these types of charts
# 2.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv))+
  geom_point()+
  geom_smooth(se=FALSE)
# this is the plot from earlier in the chapter!
# 3.
# show.legend = FALSE removes the legend for an aes
# removing it goes with the default: show.legend=TRUE
# I think it was used earlier in the chapter so that the plots would all look more similar (no legend)
# 4.
# se adds or removes the standard error ribbon on the smoothed line
# 5.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth()
ggplot()+
  geom_point(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_smooth(data=mpg, mapping=aes(x=displ, y=hwy))
# they look the same! we can specify the same aes arguments globally in ggplot or in each geom.
# 6.
# a.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(se=F)
# b.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(aes(group=drv), se=F)
# c.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv))+
  geom_point()+
  geom_smooth(se=F)
# d.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(aes(color=drv))+
  geom_smooth(se=F)
# e.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(aes(color=drv))+
  geom_smooth(aes(linetype=drv), se=F)
# f.
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(aes(fill=drv), shape=21, color="white", stroke=1.5)
# note: I'm not seeing the points surrounded by a white stroke on the example legend

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut))

ggplot(data=diamonds)+
  stat_count(mapping=aes(x=cut))

ggplot(data=diamonds)+
  stat_summary(mapping=aes(x=cut,y=depth),
               fun.min = min,
               fun.max = max,
               fun = median)

# 3.7.1 Exercises
# 1.
# the default geom for stat_summary is "pointrange"
ggplot(data=diamonds)+
  geom_pointrange(mapping=aes(x=cut, y=depth),
                  stat="summary",
                  fun.min = min,
                  fun.max = max,
                  fun = median)
# 2.
# geom_col creates a bar plot by with the height equal to the count in each group.
# geom_bar creates a bar plot with the height proportional to the number of cases in each group.
# 3.
# list all stat/geom pairs:
# stat_ecdf : geom_step, position="identity"
# stat_ellipse : geom_path, position="identity"
# stat_function : geom_function, position="identity"
# stat_identity : geom_point, position="identity"
# stat_summary_2d : geom_tile
# stat_summary_hex : geom_hex
# stat_summary_bin : geom_pointrange
# stat_summary : geom_pointrange
# stat_unique : geom_point
# stat_sf_coordinates : geom_point
# 4.
# stat_smooth computes smoothing functions, using specific functions from other packages
# so lm (from stats), glm (from stats?), gam (from mgcv), loess (from stats)
# stat_smooth is controlled by "method" (which smoothing function to fit), "formula" (what formula to use for the smooth)
# "se" can be used for functions with standard errors
# "n" is number of points at which to evaluate the smoother
# "span" is amount of smoothing for the loess
# "fullrange" is for fitting the full range of the plot (as opposed to just the existing data points)
# "level" is for level of the confidence interval
# 5.
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, y=after_stat(prop)))
# the problem here is that we don't have groups
# it's noting that for each x value, 100% of cases are in that x value
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut, fill=color, y=after_stat(prop)))
# here there are equal intervals for each color
# this is because the stat_count operation creates a small intermediate dataset with cut, count, & prop
# prop only takes one value: 1 (e.g., that's 100% of the data in that group)
# we have specified our y as that prop value (1), which is the same for all
# when we use the group=1, we say that we want the groups from the prop

ggplot(data=diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data=diamonds) +
  geom_bar(mapping = aes(x=cut, fill=cut))

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x=cut, fill=clarity))+
  geom_bar(alpha=1/5, position="identity")
ggplot(data=diamonds, mapping=aes(x=cut, color=clarity))+
  geom_bar(fill=NA, position="identity")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity),
           position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity),
           position = "dodge")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),
             position="jitter")

# 3.8.1 Exercises
# 1.
ggplot(data = mpg, mapping = aes(x=cty, y=hwy))+
  geom_point()
# with jitter added
ggplot(data = mpg, mapping = aes(x=cty, y=hwy))+
  geom_jitter()
# 2.
?geom_jitter
# width and height specify the amount of jittering
# 3.
# geom_jitter creates points with a small amount of random noise
# geom_count increases the size of points to show how many are there
# both can be used to deal with overplotting
# count retains exact locations (no noise added)
# however, count can have overlap that's difficult to visualize
ggplot(data = mpg, mapping = aes(x=cty, y=hwy))+
  geom_count()
# 4.
?geom_boxplot()
# the default position for geom_boxplot is dodge2
# this means the boxes will be side by side
ggplot(data = mpg, mapping = aes(x=cty, y=hwy)) +
  geom_boxplot(aes(group = cty))

ggplot(data = mpg, mapping = aes(x = class, y = hwy))+
  geom_boxplot()

ggplot( data = mpg, mapping = aes( x = class, y = hwy )) +
  geom_boxplot() +
  coord_flip()

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio=1) +
  labs(x=NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# 3.9.1 Exercises
# 1.
# stacked bar chart
stack_bar <- ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar()
stack_bar
# stacked bar chart using polar coordinates
stack_bar + coord_polar()
# turn it into a pie chart
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = factor(1), fill = factor(cut)),
    show.legend = TRUE,
    width = 1,
    position = "stack",
  ) +
  theme(aspect.ratio = 1) +
  coord_polar(theta = "y") +
  labs(x = NULL,
       y = NULL)
# 2.
# labs is for setting the labels
?labs
# 3.
?coord_quickmap
# coord_quickmap creates a projection of a 3D, spherical map into 2D
# coord_quickmap preserves straight lines, unlike coord_map
# coord_quickmap works best for smaller areas closer to the equator
# 4.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()
# the plot below demonstrates that cars always get better mileage on the highway than in the city.
# the abline provides the line x = y, which would be the case if mileage for vehicles was the same.
# having the abline allows us to see that all points are above it.
# coord_fixed keeps the ratio of points on x and y equal.
# having coord_fixed allows for an easier comparison of the points to the line.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline()
# without coord_fixed, the relationship is slightly distorted by the different ranges in the x & y variables in the data.
