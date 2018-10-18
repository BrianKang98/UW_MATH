# hw_lect24_1
# a)
x <- c(89, 177 ,189 ,354, 362, 442, 965)
y <- c(.40, .60, .48 ,.66 ,.61 ,.69 ,.99)
plot(x,y)

# b)
lm.1 = lm(y~x)
lm.1$coefficients[2]  # beta coeff.
# 0.0006210758
# We estimate that with each increase in x by 1 will lead to an increase in y by 0.0006210758

# c)
summary(lm.1)$sigma  # S_e
# 0.05404525
# The typical deviation of y about the fit is about 0.05404525.

# hw_lect25_1
# a)
set.seed(123) # Use this line to make sure we all get the same answes.
n = 20
y = 1 + rnorm(n,0,1)
x1 = runif(n,-1,1)
x2 = runif(n,-1,1)
x3 = runif(n,-1,1)
x4 = runif(n,-1,1)
x5 = runif(n,-1,1)
x6 = runif(n,-1,1)
x7 = runif(n,-1,1)
x8 = runif(n,-1,1)
x9 = runif(n,-1,1)
x10 = runif(n,-1,1)
lm.2 = lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10)
# test of model utility
# look at "p-value" next to the fstatistic in summary
# 0.2846
# t test on each 10 coeffs
summary(lm.2)$coeff[,4]

# b)
# 0.2846 > alpha = 0.1, therefore there are no useful predictors

# c)
# There are 4 predictors with p-value < alpha = 0.1.

# hw_lect25_2
# c)
plot(pbinom(1,1:100,0.05,lower.tail = T),1:100)
plot(pbinom(1,1:100,0.01,lower.tail = T),1:100)
