# hw_lect10_3

moe <- c(29.8,33.2,33.7,35.3,35.5,36.1,36.2,36.3,37.5,37.7,38.7,38.8,39.6,41.0,42.8,42.8,43.5,45.6,46.0,46.9,48.0,49.3,51.7,62.6,69.8,79.5,80.0)
strength <- c(5.9,7.2,7.3,6.3,8.1,6.8,7.0,7.6,6.8,6.5,7.0,6.3,7.9,9.0,8.2,8.7,7.8,9.7,7.4,7.7,9.7,7.8,7.7,11.6,11.3,11.8,10.7)

# a)
plot(strength,moe)

# b)
par(mfrow = c(1,2))
boxplot(moe)
boxplot(strength)

# c)
qqnorm(moe)
qqnorm(strength)

# e)
cor(moe,strength)
# The correlation coefficients from d and e are equal.