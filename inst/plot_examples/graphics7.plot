require(datasets)
require(graphics)
## A filled histogram, showing how to change the font used for the
## main title without changing the other annotation.

par(bg="cornsilk")
x <- rnorm(1000)
hist(x, xlim=range(-4, 4, x), col="lavender", main="")
title(main="1000 Normal Random Variates", font.main=3)


