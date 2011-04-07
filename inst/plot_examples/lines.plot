par(mfrow=c(3,3))
x <- c(1.5,2,3,2,2)
y <- c(2.5,1,3,2,2.5)
for (i in c(0,1,2)) {
	for (j in c(0,1,2)) {
		par(lend=i,ljoin=j)
		plot(x,y,lwd=4,type="l")
	}
}
