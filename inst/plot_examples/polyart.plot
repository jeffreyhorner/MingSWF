# Added here instead of from NRart to control printing of margins
nr.image <- function (expr, centre = c(0, 0), zoom = 1, xrange = c(centre[1] -
				zoom, centre[1] + zoom), yrange = c(centre[2] - zoom, centre[2] +
					zoom), points = 150, steps = 5, each, display = image, main = deparse(substitute(expr)),
			addtext=TRUE,...)
{
	expr <- substitute(expr)
	stopifnot(is.call(expr))
	variable <- all.vars(expr)
	stopifnot(length(variable) == 1)
	main
	derivative <- D(expr, variable)
	name <- as.name(variable)
		expr <- substitute(name - expr/derivative)
		assign(variable, outer(seq(xrange[1], xrange[2], length = points),
					seq(yrange[1], yrange[2], length = points) * (0+1i),
					"+"))
		display.annotated <- function() {
				if (addtext){
					display(Arg(eval(name)), main = main, bty = "n", xaxt = "n",
							yaxt = "n", ...)
				mtext(paste("step", "=", step), side = 1, line = 2, font = 2,
						adj = 0.9)
				axis(side = 1, at = c(0, 0.5, 1), labels = c(format(xrange[1],
								digits = 3), format(centre[1], digits = 3), format(xrange[2],
									digits = 3)))
				axis(side = 2, at = c(0, 0.5, 1), labels = c(paste(format(yrange[1],
									digits = 3), "i", sep = ""), paste(format(centre[2],
										digits = 3), "i", sep = ""), paste(format(yrange[2],
											digits = 3), "i", sep = "")))
				} else {
					par(mar=c(0,0,0,0))
					display(Arg(eval(name)), bty = "n", xaxt = "n",
							yaxt = "n", ...)
				}
		}
	for (step in 1:steps) {
		if (!missing(each) && step%%each == 0)
			display.annotated()
				assign(variable, eval(expr))
	}
	if (missing(each) || step%%each != 0)
		display.annotated()
			invisible(eval(name))
}
nr.image(x^3+1)
