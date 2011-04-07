x <- seq(-4, 4, len = 101)
y <- cbind(sin(x), cos(x))
matplot(x, y, type = "l", xaxt = "n",
main = expression(paste(plain(sin) * phi, " and ", plain(cos) * phi)),
	ylab = expression("sin" * phi, "cos" * phi), # only 1st is taken
	xlab = expression(paste("Phase Angle ", phi)),
	col.main = "blue")
axis(1, at = c(-pi, -pi/2, 0, pi/2, pi), labels = expression(-pi, -pi/2, 0, pi/2, pi))
