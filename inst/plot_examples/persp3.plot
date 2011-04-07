
### Demos for  persp()  plots   -- things not in  example(persp)
### -------------------------

require(datasets)
require(graphics)



par(bg = "white")

## (2) Visualizing a simple DEM model

z <- 2 * volcano        # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)
persp(x, y, z, theta = 120, phi = 15, scale = FALSE, axes = FALSE)
