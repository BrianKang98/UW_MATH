# hw_lect7_1

# Part C
 x <- read.csv("prussian_horse_kills", header = F)
 xdat <- stack(x)[,1]
 plot(xdat,dpois(xdat,1))
 
# ---------------------------------------------------

# hw_lect8_5

# get sample sizes
z = numeric(100)
# assign different sample sizes to different vars
for (i in 1:100) {
  assign(paste("x_",i,sep = ""), rexp(i^2,1/2))
  z[i] = i^2
}

# get means
x = numeric(100)
for (i in 1:100) {
  x[i] = mean(get(paste("x_",i,sep = "")))
}
# get std devs
y = numeric(100)
for (i in 1:100) {
  y[i] = sd(get(paste("x_",i,sep = "")))
}

# mean and std dev versus sample size
plot(x,z,col = "black")
points(y,z, col = "red")
