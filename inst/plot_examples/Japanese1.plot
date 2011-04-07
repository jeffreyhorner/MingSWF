require(graphics)

## --- Japanese characters in the Hershey Vector Fonts

######
# create tables of Japanese characters
######
make.table <- function(nr, nc) {
    opar <- par(mar=rep(0, 4), pty="s")
    plot(c(0, nc*(10%/%nc) + 1), c(0, -(nr + 1)),
         type="n", xlab="", ylab="", axes=FALSE)
    invisible(opar)
}

get.r <- function(i, nr)   i %% nr + 1
get.c <- function(i, nr)   i %/% nr + 1
Esc2 <- function(str)	   paste("\\", str, sep="")

draw.title <- function(title, nc)
    text((nc*(10%/%nc) + 1)/2, 0, title, font=2)

draw.vf.cell <- function(typeface, fontindex, string, i, nr, raw.string=NULL) {
    r <- get.r(i, nr)
    c <- get.c(i, nr)
    x0 <- 2*(c - 1)
    if (is.null(raw.string)) raw.string <- Esc2(string)
    text(x0 + 1.1, -r, raw.string, col="grey")
    text(x0 + 2,   -r, string, vfont=c(typeface, fontindex))
    rect(x0 +  .5, -(r - .5), x0 + 2.5, -(r + .5), border="grey")
}

draw.vf.cell2 <- function(string, alt, i, nr) {
    r <- get.r(i, nr)
    c <- get.c(i, nr)
    x0 <- 3*(c - 1)
    text(x0 + 1.1, -r, Esc2(string <- Esc2(string)), col="grey")
    text(x0 + 2.2, -r, Esc2(Esc2(alt)), col="grey", cex=.6)
    text(x0 + 3,   -r, string, vfont=c("serif", "plain"))
    rect(x0 +  .5, -(r - .5), x0 + 3.5, -(r + .5), border="grey")
}

tf <- "serif"
fi <- "plain"
nr <- 25
nc <- 4
oldpar <- make.table(nr, nc)
index <- 0
digits <- c(0:9,"a","b","c","d","e","f")
draw.title("Hiragana : \\\\#J24nn", nc)
for (i in 2:7) {
    for (j in 1:16) {
	if (!((i == 2 && j == 1) || (i == 7 && j > 4))) {
	    draw.vf.cell(tf, fi, paste("\\#J24", i, digits[j], sep=""),
	                 index, nr)
            index <- index + 1
	}
    }
}
