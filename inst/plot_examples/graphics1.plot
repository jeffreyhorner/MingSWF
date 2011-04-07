require(datasets)
require(graphics)


## Here is some code which illustrates some of the differences between
## R and S graphics capabilities.  Note that colors are generally specified
## by a character string name (taken from the X11 rgb.txt file) and that line
## textures are given similarly.	 The parameter "bg" sets the background
## parameter for the plot and there is also an "fg" parameter which sets
## the foreground color.


x <- rnorm(50)
#opar <- c(opar, par(bg = "white"))
plot(x, ann = FALSE, type = "n")
abline(h = 0, col = gray(.90))
lines(x, col = "orange", lty = "dotted")
points(x, bg = "red", pch = 21)
title(main = "Simple Use of Color In a Plot",
      xlab = "Just a Whisper of a Label",
      col.main = "blue", col.lab = gray(.8),
      cex.main = 1.2, cex.lab = 1.0, font.main = 4, font.lab = 3)
