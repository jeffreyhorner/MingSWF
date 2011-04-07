require(datasets)
require(graphics)

## Conditioning plots

par(bg="cornsilk")
coplot(lat ~ long | depth, data = quakes, pch = 21, bg = "green3")
