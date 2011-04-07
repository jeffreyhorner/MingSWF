require(datasets)
require(graphics)

## Boxplots:  I couldn't resist the capability for filling the "box".
## The use of color seems like a useful addition, it focuses attention
## on the central bulk of the data.

par(bg="cornsilk")
n <- 10
g <- gl(n, 100, n*100)
x <- rnorm(n*100) + sqrt(as.numeric(g))
boxplot(split(x,g), col="lavender", notch=TRUE)
title(main="Notched Boxplots", xlab="Group", font.main=4, font.lab=1)
