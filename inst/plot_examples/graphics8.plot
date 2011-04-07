require(datasets)
require(graphics)

## A scatterplot matrix
## The good old Iris data (yet again)

#pairs(iris[1:4], main="Edgar Anderson's Iris Data", font.main=4, pch=19)
pairs(iris[1:4], main="Edgar Anderson's Iris Data", pch=21,
      bg = c("red", "green3", "blue")[unclass(iris$Species)])
