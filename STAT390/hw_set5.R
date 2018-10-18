# hw_lect9_2
# a)
x <- runif(1000, -1, 1)
qqnorm(x)
# b)
# -infinity, 0, +infinity respectively
# c)
# -1, 0, 1 respectively
# (CONT. on paper...)

# hw_lect9_3
library(Zelig)
data("PErisk")
dat <- PErisk[,c("barb2", "prsexp2", "prscorr2", "gdpw2")]
# display both qqplots
par(mfrow = c(1,2))
qqnorm(dat$barb2)
qqnorm(dat$gdpw2)

# Starting with the second qqplot, we might be able to say
# that the sample is generally consistent with a standard
# normal because there is a single line that can be drawn
# along the points in the general middle, but if we consider
# the left and right tails, we can possibly see that it can
# follow the shape of the uniform v. normal qqplot from 
# hw_lect9_2 A (my sample has that slight S shape generally).
# The intercept at x=0 is around y=9.25 and that seems like
# the general location of the center.
# qqplot(runif(1000,-5,5), dat$gdpw2, main = "Sample2 v. Uniform")
# The qqplot of this sample v. uniform dist. seems promising.

# Now, the first qqplot. It is hard to say that this sample
# is consistent with a standard normal distribution. We can
# see a roughtly straight line from the middle to the top
# right, but the bottom and left is different. We can see
# a horizontal line along the consisten very negative values
# at the very bottom, but the values between these points to
# the middle seem to show a different straight line apart from
# the others. The intercept at x=0 is around y=-1 where a
# cluster of values are located. But I don't think that is
# is very useful for the overall picture.

# hw_lect9_4
plot(dat$barb2, dat$gdpw2)

# There seems to be almost no relation between the two data.
# The data seems to be scattered randomly except the top left
# corcer. If we really had to say that there is a certain
# shape, I would say it is one with linear and non-constant-
# -very-wide variance pointing from the top left to opposite.
# But still there seems to be very unlike to be associated.

