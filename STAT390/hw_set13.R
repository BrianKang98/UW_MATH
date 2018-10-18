# hw_lect22_3
# a)
temp1 = c(59.5, 53.3, 56.8, 63.1, 58.7)
temp2 = c(55.2, 59.1, 52.8, 54.4, NA)
temp3 = c(51.7, 48.4, 53.9, 49.0, NA)
temp4 = c(44.6, 48.5, 41.0, 47.3, 46.1)
mat = matrix(c(temp1,temp2,temp3,temp4),ncol=5,byrow=T)

# how make the table????????????
dat <- data.frame("Pressure" = matrix(c(1.6,3.8,6.0,10.2)), "Temperature" = mat)
boxplot(temp1,temp2,temp3,temp4)

# b)
# Yes. If compare the boxplot from pressure 1.6 to 10.2, there is absolutely no overlap in the boxplot at all.

# c)
aov.1 = aov(Pressure ~ as.factor(Temperature), data = dat)
# should = 7.541411e-07
# Because 7.541411e-07 < 0.05 = Alpha, we reject the null hypothesis that the true mean melting temperatures for different pressures are the equal, in favor of the alternative that there are at least two different true means.

# d)
k <- 4
n <- m <- s <- numeric(k)
n[1] = 5; n[2] = 4; n[3] = 4; n[4] = 5;
m[1] = mean(mat[1,]); m[2] = mean(mat[2,1:4]); m[3] = mean(mat[3,1:4]); m[4] = mean(mat[4,])
s[1] = sd(mat[1,]); s[2] = sd(mat[2,1:4]); s[3] = sd(mat[3,1:4]); s[4] = sd(mat[4,])

df.1 <- k-1
df.2 <- k*6-k
SSB <- sum(n*(m-mean(m)) ^ 2)  # between
SSW <- sum((n-1) * s ^2)  # within
MSB <- SSB / df.1
MSW <- SSW / df.2
F <- MSB/MSW
p.value <- 1-pf(F,df.1,df.2)
# 7.541411e-07

# e)
y1 = mat[1,]
n = length(y1)
probs = seq(0.5/n, 1-0.5/n, length=n)
Q = qnorm(probs,0,1)
plot(Q, sort(y1), xlim=c(-2,2), ylim=range(c(min(c(mat[1,],mat[2,1:4],mat[3,1:4],mat[4,])),max(c(mat[1,],mat[2,1:4],mat[3,1:4],mat[4,])))),col = 1)

y2 = mat[2,1:4]
n = length(y2)
probs = seq(0.5/n, 1-0.5/n, length=n)
Q = qnorm(probs)
points(Q, sort(y2), col = 2)

y3 = mat[3,1:4]
n = length(y3)
probs = seq(0.5/n, 1-0.5/n, length=n)
Q = qnorm(probs)
points(Q, sort(y3),col = 3)

y4 = mat[4,]
n = length(y4)
probs = seq(0.5/n, 1-0.5/n, length=n)
Q = qnorm(probs)
points(Q, sort(y4),col = 4)
# The 4 qqplots are all reasonably straight and have reasonable equal slops.

# hw_lect23_1
# a)
n = 100
n.trial = 5000
x = c(1:n)
y_true = 20 + 2*x + 0.1*x^2
sigma_eps = 20
alpha_hat = {}
beta1_hat = {}
beta2_hat = {}
for(trial in 1:n.trial) {
  y_obs = y_true + rnorm(n,0,sigma_eps)
  lm.1 = lm(y_obs ~ x + I(x^2))
  alpha_hat = c(alpha_hat,lm.1$coefficients[1])
  beta1_hat = c(beta1_hat,lm.1$coefficients[2])
  beta2_hat = c(beta2_hat,lm.1$coefficients[3])
}

# b)
qqnorm(alpha_hat)
qqnorm(beta1_hat)
qqnorm(beta2_hat)
# all normal

# c)
mean(alpha_hat)
# 20.09883 approx 20
mean(beta1_hat)
# 1.995656 approx 2
mean(beta2_hat)
# 0.1000289 approx 0.1

# d)
sd(beta1_hat)
# 0.2792859
sigma_eps/sum((x-mean(x))^2)
# 0.000240024
# not equal

