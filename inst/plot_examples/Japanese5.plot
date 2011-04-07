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

make.table(nr, nc)
i <- 0
draw.title("Kanji (3)", nc)
draw.vf.cell2("#J3835", "#N0275", i, nr); i <- i + 1
draw.vf.cell2("#J3836", "#N0825", i, nr); i <- i + 1
draw.vf.cell2("#J3839", "#N1568", i, nr); i <- i + 1
draw.vf.cell2("#J383a", "#N2637", i, nr); i <- i + 1
draw.vf.cell2("#J383b", "#N2656", i, nr); i <- i + 1
draw.vf.cell2("#J383d", "#N2943", i, nr); i <- i + 1
draw.vf.cell2("#J3840", "#N4309", i, nr); i <- i + 1
draw.vf.cell2("#J3842", "#N4987", i, nr); i <- i + 1
draw.vf.cell2("#J3845", "#N0770", i, nr); i <- i + 1
draw.vf.cell2("#J3847", "#N1036", i, nr); i <- i + 1
draw.vf.cell2("#J384c", "#N1567", i, nr); i <- i + 1
draw.vf.cell2("#J384d", "#N1817", i, nr); i <- i + 1
draw.vf.cell2("#J384e", "#N2044", i, nr); i <- i + 1
draw.vf.cell2("#J385d", "#N5415", i, nr); i <- i + 1
draw.vf.cell2("#J385e", "#N0015", i, nr); i <- i + 1
draw.vf.cell2("#J3861", "#N0162", i, nr); i <- i + 1
draw.vf.cell2("#J3865", "#N1610", i, nr); i <- i + 1
draw.vf.cell2("#J3866", "#N1628", i, nr); i <- i + 1
draw.vf.cell2("#J386c", "#N4374", i, nr); i <- i + 1
draw.vf.cell2("#J3872", "#N0290", i, nr); i <- i + 1
draw.vf.cell2("#J3877", "#N1358", i, nr); i <- i + 1
draw.vf.cell2("#J3878", "#N0579", i, nr); i <- i + 1
draw.vf.cell2("#J387d", "#N0868", i, nr); i <- i + 1
draw.vf.cell2("#J387e", "#N0101", i, nr); i <- i + 1
draw.vf.cell2("#J3929", "#N1451", i, nr); i <- i + 1
draw.vf.cell2("#J3931", "#N1683", i, nr); i <- i + 1
draw.vf.cell2("#J393d", "#N2343", i, nr); i <- i + 1
draw.vf.cell2("#J3943", "#N0092", i, nr); i <- i + 1
draw.vf.cell2("#J394d", "#N3684", i, nr); i <- i + 1
draw.vf.cell2("#J3954", "#N4213", i, nr); i <- i + 1
draw.vf.cell2("#J3955", "#N1641", i, nr); i <- i + 1
draw.vf.cell2("#J395b", "#N4843", i, nr); i <- i + 1
draw.vf.cell2("#J395d", "#N4883", i, nr); i <- i + 1
draw.vf.cell2("#J395f", "#N4994", i, nr); i <- i + 1
draw.vf.cell2("#J3960", "#N1459", i, nr); i <- i + 1
draw.vf.cell2("#J3961", "#N5188", i, nr); i <- i + 1
draw.vf.cell2("#J3962", "#N5248", i, nr); i <- i + 1
draw.vf.cell2("#J3966", "#N0882", i, nr); i <- i + 1
draw.vf.cell2("#J3967", "#N0383", i, nr); i <- i + 1
draw.vf.cell2("#J3971", "#N1037", i, nr); i <- i + 1
draw.vf.cell2("#J3975", "#N5403", i, nr); i <- i + 1
draw.vf.cell2("#J397c", "#N5236", i, nr); i <- i + 1
draw.vf.cell2("#J397e", "#N4660", i, nr); i <- i + 1
draw.vf.cell2("#J3a21", "#N2430", i, nr); i <- i + 1
draw.vf.cell2("#J3a23", "#N0352", i, nr); i <- i + 1
draw.vf.cell2("#J3a2c", "#N2261", i, nr); i <- i + 1
draw.vf.cell2("#J3a38", "#N1455", i, nr); i <- i + 1
draw.vf.cell2("#J3a39", "#N3662", i, nr); i <- i + 1
draw.vf.cell2("#J3a42", "#N1515", i, nr); i <- i + 1
draw.vf.cell2("#J3a46", "#N0035", i, nr); i <- i + 1
draw.vf.cell2("#J3a47", "#N2146", i, nr); i <- i + 1
draw.vf.cell2("#J3a59", "#N3522", i, nr); i <- i + 1
draw.vf.cell2("#J3a5f", "#N1055", i, nr); i <- i + 1
draw.vf.cell2("#J3a6e", "#N0407", i, nr); i <- i + 1
draw.vf.cell2("#J3a72", "#N2119", i, nr); i <- i + 1
draw.vf.cell2("#J3a79", "#N2256", i, nr); i <- i + 1
draw.vf.cell2("#J3b2e", "#N3113", i, nr); i <- i + 1
draw.vf.cell2("#J3b30", "#N0008", i, nr); i <- i + 1
draw.vf.cell2("#J3b33", "#N1407", i, nr); i <- i + 1
draw.vf.cell2("#J3b36", "#N2056", i, nr); i <- i + 1
draw.vf.cell2("#J3b3b", "#N3415", i, nr); i <- i + 1
draw.vf.cell2("#J3b40", "#N4789", i, nr); i <- i + 1
draw.vf.cell2("#J3b45", "#N0362", i, nr); i <- i + 1
draw.vf.cell2("#J3b4d", "#N1025", i, nr); i <- i + 1
draw.vf.cell2("#J3b4e", "#N1160", i, nr); i <- i + 1
draw.vf.cell2("#J3b4f", "#N1208", i, nr); i <- i + 1
draw.vf.cell2("#J3b52", "#N1264", i, nr); i <- i + 1
draw.vf.cell2("#J3b54", "#N0284", i, nr); i <- i + 1
draw.vf.cell2("#J3b57", "#N3001", i, nr); i <- i + 1
draw.vf.cell2("#J3b58", "#N1904", i, nr); i <- i + 1
draw.vf.cell2("#J3b59", "#N2039", i, nr); i <- i + 1
draw.vf.cell2("#J3b5e", "#N2211", i, nr); i <- i + 1
draw.vf.cell2("#J3b5f", "#N2429", i, nr); i <- i + 1
draw.vf.cell2("#J3b60", "#N2439", i, nr); i <- i + 1
draw.vf.cell2("#J3b61", "#N2478", i, nr); i <- i + 1
draw.vf.cell2("#J3b64", "#N3265", i, nr); i <- i + 1
