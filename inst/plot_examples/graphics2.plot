require(datasets)
require(graphics)

## A little color wheel.	 This code just plots equally spaced hues in
## a pie chart.	If you have a cheap SVGA monitor (like me) you will
## probably find that numerically equispaced does not mean visually
## equispaced.  On my display at home, these colors tend to cluster at
## the RGB primaries.  On the other hand on the SGI Indy at work the
## effect is near perfect.

par(bg = "gray")
pie(rep(1,24), col = rainbow(24), radius = 0.9)
title(main = "A Sample Color Wheel", cex.main = 1.4, font.main = 3)
title(xlab = "(Use this as a test of monitor linearity)",
      cex.lab = 0.8, font.lab = 3)
