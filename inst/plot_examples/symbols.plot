Pex <- 3 ## good for both .Device=="postscript" and "x11"
ipch <- 0:35; np <- length(ipch); k <- floor(sqrt(np)); dd <- c(-1,1)/2
rx <- dd + range(ix <- ipch %/% k)
ry <- dd + range(iy <- 3 + (k-1)- ipch %% k)
pch <- as.list(ipch)
pch[26+ 1:10] <- as.list(c("*",".", "o","O","0","+","-","|","%","#"))
plot(rx, ry, type="n", axes = FALSE, xlab = "", ylab = "",
			 main = paste("plot symbols :  points (...  pch = *, cex =", Pex,")"))
abline(v = ix, h = iy, col = "lightgray", lty = "dotted")
for(i in 1:np) {
	  pc <- pch[[i]]
			points(ix[i], iy[i], pch = pc, col = "red", bg = "yellow", cex = Pex)
			  ## red symbols with a yellow interior (where available)
			  text(ix[i] - .3, iy[i], pc, col = "brown", cex = 1.2)
}
