# hw_lect11_3
x = c(45, 58, 71, 71, 85, 98, 108)
y = c(3.20, 3.40, 3.47, 3.55, 3.60, 3.70, 3.80)

# a)
lm.r = lm(y~x)
lm.r

# Intercept = 2.855944, x (Slope) = 0.008822
# Interpretation:
# When the x value = 0, we predict that the y value is
# about 2.855944
# An increase in the x value by 1 is associated with an
# average increase in the y value by 0.008822

# b)
plot(x,y, main = "Scatterplot of X v. Y")
abline(lm.r)

# c)
summary(lm.r)$r.squared

# R^2 = 0.9614587
# Interpretation:
# 96.146% of the variability in the y variable can be
# explained by the linear relation with x

# d)
summary(lm.r)$sigma

# s_e = sqrt(variance of error) = 0.04269537
# Interpretation:
# The typical deviation of y about the fit is about
# 0.0427 units.

# ----------------------------------------------------

# hw_lect12_2

# a)
dat <- read.table("https://www.stat.washington.edu/marzban/390/summer18/transform_dat.txt", header = T)
plot(dat[,1],dat[,2])
plot(sqrt(dat[,1]),sqrt(dat[,2]))

# b)
lm.1 <- lm(sqrt(dat[,2])~sqrt(dat[,1]))
abline(lm.1)

# c)
summary(lm.1)$r.squared
# 99.225% of the variability in the transformed y is
# explained by the transformed x
summary(lm.1)$sigma
# The typical error in the prediction of the transformed
# y is 0.01911

# d)
# NO R, BY HAND

# e)
xx = dat[,1]
yy = dat[,2]
#plot(xx+sqrt(xx),yy)
lm.2 <- lm(yy ~ xx + I(sqrt(xx)))
# makes the predictions using model then connect
# those points with lines
#lines(xx+sqrt(xx),predict(lm.2))

# f)
par(mfrow = c(1,2))
plot(sqrt(xx),predict(lm.1))
plot(xx+sqrt(xx),predict(lm.2))
