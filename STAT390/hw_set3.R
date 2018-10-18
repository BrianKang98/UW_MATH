# hw_lect6_1

# install.packages(c("survival", "Zelig"))
# library(survival)
library(Zelig)
# 2 categorical/discrete: barb2 and gdpw2
# 2 continuous: prsexp2 and prscorr2
data("PErisk")
dat <- PErisk
# subset the function to extract the columns (or variables) I want
modifiedDat <- dat[,c("barb2", "prsexp2", "prscorr2", "gdpw2")]

# save data of barb2 = Black Market Premium to variable,
# for each level of prsexp2 = Lack of Expropriation Risk
cont0 <- modifiedDat[modifiedDat$prsexp2==0,]$barb2
cont1 <- modifiedDat[modifiedDat$prsexp2==1,]$barb2
cont2 <- modifiedDat[modifiedDat$prsexp2==2,]$barb2
cont3 <- modifiedDat[modifiedDat$prsexp2==3,]$barb2
cont4 <- modifiedDat[modifiedDat$prsexp2==4,]$barb2
cont5 <- modifiedDat[modifiedDat$prsexp2==5,]$barb2
# sort each unique level
lv <- sort(unique(modifiedDat$prsexp2))

# horizontal boxplot
boxplot(cont0, cont1, cont2, cont3, cont4, cont5, 
ylab = "Lack of Expropriation Risk (Level)", 
xlab = "Ln (Black Market Premium)", 
horizontal = T, at = lv)
axis(2,lv)

# Interpretation: 
# I think we can see a rough trend that overall the level of LACK
# of expropriation risk from a government is inversly related to
# the black market premium (high level <-> lower premium). For the
# box plot of level 5, it looks like there were many numbers with the
# same value that the min,1st 2nd 3rd quartiles,max are all equal, so
# producing outliers outside of that compact range. Level 4,3 both have
# a wide spread and similar sizes of range and the box. Level 2 is
# relatively compact, having a small box and range. Level 1 has a big
# box compared to its "whiskers," indicating that there are more
# values in the sorted center than toward the high and low end.
# Level 1 has a very wide box with no "whiskers" (our data indicates
# that this level only has 2 values). It is difficult to clearly say
# that each boxplot is located "higher or lower" due to their spread
# and uncertain true center of the plot, especially when comparing the
# levels 3 & 2 and 1 & 0.

# -----------------------------------------------------------------------

# hw_lect6_2

# Part II

# d)
datt <- read.table(
  "https://www.stat.washington.edu/marzban/390/summer18/temp_dat.txt",
  header = T)
boxplot(datt)

# e)
# There is NO evidence that OR is warmer than WA. All the values
# displayed on the boxplot seem to nearly identical. They have very
# similar range, min, max, IQR, median, 1st and 3rd quartiles. Due
# to the huge overlap of data according to the boxplot, we cannot
# concluded that OR is warmer than WA.

# f)
# I think there is reasonable data to say that CA is warmer than WA.
# Although CA seems to have similar spread (range and IQR) and similar
# location of center within the IQR, around the middle, the values
# themselves indicate that they are approximately 15 units higher.
# Therefore, I think it is understandable to say that the mean of
# temperature at CA is higher than that of WA, so I say overall it is
# reasonable to conclude CA is warmer than WA.

# g)
Tdatt <- t(datt)
boxplot(Tdatt)

# h)
# All WA, OR, and CA are in the westcoast. There is NO evidence that
# temperatures in July and August are different in the westcoast for
# similar reasons listed in (e). The boxplots seem to be almost
# identical; the heavily skewed shape (due to only having 3 values),
# the spread of range and box, the center median all are very similar.
# Due to this huge overlap we cannot reach the conclusion that July
# is warmer than Auguest in the westcoast.

# Part III

# i)
dattt <- as.matrix(read.table("https://www.stat.washington.edu/marzban/390/summer18/inter_arrival_dat.txt",
                              header = T))
# "inter arrival time" is an example of exp. dist.
# hist(dattt)    # to check that this is expoential
quantile(dattt, probs = 0.10)    # shortest 10%
# gives the value, answer = 0.1608677
