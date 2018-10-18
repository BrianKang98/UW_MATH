# Brian Kang
# hw_lect2_1

# if survial and Zelig (depend on survival) packages are not installed
# install.packages(c("survival", "Zelig"))
# library(survival)
library(Zelig)

# I will be using the PErisk function's barb2, prsexp2, prscorr2, gdpw2
# variables for my 2 categorical/discrete and 2 continuous variables
# 2 categorical/discrete: barb2 and gdpw2
# 2 continuous: prsexp2 and prscorr2

# part a)
data("PErisk")
dat <- PErisk
# subset the function to extract the columns (or variables) I want
modifiedDat <- dat[,c("barb2", "prsexp2", "prscorr2", "gdpw2")]
# print the data in indicated format
print(modifiedDat)

# part b)
# makes 2x2 grid to display the 4 histograms
par(mfrow = c(2,2))
# plot histograms for each of the 4 variables
# continuous variables will be assigned bins ("breaks")
# discrete variables will be plotted
hist(dat[,3], breaks = seq(-7, 3, by = 1))
hist(dat[,4])
hist(dat[,5])
hist(dat[,6], breaks = 15)

# refresh for next problem
par(mfrow = c(1,1))

# -----------------------------------------------------------------------

# hw_lect2_2

# Amount learned:	41%	27%	22%	2%	6%	2%
# "51" surveyed

# part a)
# a temp variable containing the each levels' percent
temp <- c(0.41, 0.27, 0.22, 0.02, 0.06, 0.02)
# contains the counts for each level of the rv
# the round() command was used to round the decimal values
counts <- round(temp*51)

# part b)
# plot(c(5:0), counts, type="h")
# rep(c(5,4), c(21,14)) generates 21 5s and 14 4s
# generate and contains rv data using the counts
histDat = rep(c(5,4,3,2,1,0), counts)

# part C)
# to see the histogram with visible bars
# hist(histDat, breaks = 20) 
# to see histogram that looks like the one from plot()
# (to make the boxes basically look like lines)
hist(histDat, breaks = 36000)

# refresh for next problem
par(mfrow = c(1,1))

# -----------------------------------------------------------------------

# 1.16
idtDat <- c(28.1,31.2,13.7,46.0,25.8,16.8,34.8,62.3,
            28.0,17.9,19.5,21.1,31.9,28.9,60.1,23.7,
            18.6,21.4,26.6,26.2,32.0,43.5,17.4,38.8,
            30.6,55.6,25.5,52.1,21.0,22.3,15.5,36.3,
            19.1,38.4,72.8,48.9,21.4,20.7,57.3,40.9)
# create histogram with class length of 10
hist(idtDat, breaks = seq(10, 80, by = 10))
# could have just done
# hist(idtDat)

# create histogram of data log_10(data) with class length of 0.1
idtModDat = log10(idtDat)
hist(idtModDat, breaks = seq(1.1, 2.0, by = 0.1))
# did not do 1.9 just for extra clarity

# The logarithmic transformation yielded a set of numbers with
# "nicer" looking data. The new histogram is more bell shaped and
# the mode (1.4) is close to both median (1.448) and mean (1.47),
# although it seems to be possibly bimodal. On the other hand,
# the original data is right skewed (the "tail" is on the right end) 
# and seemingly unimodal.
