library(grid)
plotcol2d <- function(cols){
        x <- 1:255
        y <- 1:length(cols)


        pushViewport(plotViewport(c(5.1,4.1,4.1,2.1)))
        pushViewport(dataViewport(x,y))
        grid.rect()
        grid.yaxis(y,label=cols,gp=gpar(fontsize=6))
        grid.xaxis()
        red = col2rgb(cols)[1,]
        green = col2rgb(cols)[2,]
        blue = col2rgb(cols)[3,]
        for (i in y){
                grid.lines(c(1,255),i,default.units="native",gp=gpar(col=cols[i],lwd=20),draw=TRUE)
        }
        grid.points(red,y,pch=16,gp=gpar(col="red"),draw=TRUE)
        grid.points(green,y,pch=16,gp=gpar(col="green"),draw=TRUE)
        grid.points(blue,y,pch=16,gp=gpar(col="blue"),draw=TRUE)
        popViewport(2)
}
plotcol2d(rainbow(10))
