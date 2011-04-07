
### Demos for  persp()  plots   -- things not in  example(persp)
### -------------------------

require(datasets)
require(graphics)


z <- 2 * volcano        # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)

par(bg = "white")

## (3) Now something more complex
##     We border the surface, to make it more "slice like"
##     and color the top and sides of the surface differently.

z0 <- min(z) - 20
z <- rbind(z0, cbind(z0, z, z0), z0)
x <- c(min(x) - 1e-10, x, max(x) + 1e-10)
y <- c(min(y) - 1e-10, y, max(y) + 1e-10)

fill <- matrix("green3", nr = nrow(z)-1, nc = ncol(z)-1)
fill[ , i2 <- c(1,ncol(fill))] <- "gray"
fill[i1 <- c(1,nrow(fill)) , ] <- "gray"

par(bg = "lightblue")
persp(x, y, z, theta = 120, phi = 15, col = fill, scale = FALSE, axes = FALSE)
title(main = "Maunga Whau\nOne of 50 Volcanoes in the Auckland Region.",
      font.main = 4)
