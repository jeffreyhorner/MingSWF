require(datasets)
require(graphics)

## Contour plotting
## This produces a topographic map of one of Auckland's many volcanic "peaks".

x <- 10*1:nrow(volcano)
y <- 10*1:ncol(volcano)
lev <- pretty(range(volcano), 10)
par(bg = "lightcyan")
pin <- par("pin")
xdelta <- diff(range(x))
ydelta <- diff(range(y))
xscale <- pin[1]/xdelta
yscale <- pin[2]/ydelta
scale <- min(xscale, yscale)
xadd <- 0.5*(pin[1]/scale - xdelta)
yadd <- 0.5*(pin[2]/scale - ydelta)
plot(numeric(0), numeric(0),
     xlim = range(x)+c(-1,1)*xadd, ylim = range(y)+c(-1,1)*yadd,
     type = "n", ann = FALSE)
usr <- par("usr")
rect(usr[1], usr[3], usr[2], usr[4], col="green3")
contour(x, y, volcano, levels = lev, col="yellow", lty="solid", add=TRUE)
box()
title("A Topographic Map of Maunga Whau", font= 4)
title(xlab = "Meters North", ylab = "Meters West", font= 3)
mtext("10 Meter Contour Spacing", side=3, line=0.35, outer=FALSE,
      at = mean(par("usr")[1:2]), cex=0.7, font=3)
