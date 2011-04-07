require(datasets)
require(graphics)

## Colored plot margins, axis labels and titles.	 You do need to be
## careful with these kinds of effects.	It's easy to go completely
## over the top and you can end up with your lunch all over the keyboard.
## On the other hand, my market research clients love it.

x <- c(0.00, 0.40, 0.86, 0.85, 0.69, 0.48, 0.54, 1.09, 1.11, 1.73, 2.05, 2.02)
par(bg="lightgray")
plot(x, type="n", axes=FALSE, ann=FALSE)
usr <- par("usr")
rect(usr[1], usr[3], usr[2], usr[4], col="cornsilk", border="black")
lines(x, col="blue")
points(x, pch=21, bg="lightcyan", cex=1.25)
axis(2, col.axis="blue", las=1)
axis(1, at=1:12, lab=month.abb, col.axis="blue")
box()
title(main= "The Level of Interest in R", font.main=4, col.main="red")
title(xlab= "1996", col.lab="red")
