# hw_lect3_3

x <- read.table("https://www.stat.washington.edu/marzban/390/summer18/hw_lect3_dat.txt")
par(mfrow = c(2,3)) # to disply all graphs at once

# the first column
H1 = hist(x[,1], plot = F)  # dont gragh the histogram
plot(H1$mids, H1$density)  # same as hist of x[,1]
plot(H1$mids, log(H1$density), main = "Exponential")
plot(log(H1$mids), log(H1$density), main = "Power-Law")

# the second column
H2 = hist(x[,2], plot = F)  # dont gragh the histogram
plot(H2$mids, H2$density)  # same as hist of x[,2]
plot(H2$mids, log(H2$density), main = "Exponential")
plot(log(H2$mids), log(H2$density), main = "Power-Law")

# The second column is clearly suitable for an exponential histogram compared to first.
# You can see a linear line created from connecting the plotted dots, compared to first
# which you can still see an exponential looking shape.

# In terms of the power-law histogram, I think the first column is more suitable.
# You can see a linear line through half of the dots plotted and the rest also fit
# relatively well to that line extended. On the other hand, from the second column's,
# you can see a concave down and decreasing curve that fits well along the all dots.
# I believe we will later learn a better way to determine by using residuals.

# ------------------------------------------------------------------------------------

# hw_lect4_2
# part c)

# f(x) from 0<x<2
xm = seq(0,2,0.005)
ym = 3/14*(-xm^3+xm^2+xm+2)
# actually from -Inf to 0 and from 2 to Inf
xl = c(-2:0)
xr = c(2:4)
y = rep(0,length(xl))
plot(xm,ym,type = "l", ylim = c(0,1), xlim = c(-1,3))
lines(xl,y,type = "l")
lines(xr,y,type = "l")
