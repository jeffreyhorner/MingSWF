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
draw.title("Kanji (2)", nc)
draw.vf.cell2("#J342c", "#N1466", i, nr); i <- i + 1
draw.vf.cell2("#J3433", "#N1492", i, nr); i <- i + 1
draw.vf.cell2("#J3434", "#N0790", i, nr); i <- i + 1
draw.vf.cell2("#J3436", "#N1731", i, nr); i <- i + 1
draw.vf.cell2("#J3437", "#N1756", i, nr); i <- i + 1
draw.vf.cell2("#J3445", "#N2988", i, nr); i <- i + 1
draw.vf.cell2("#J3449", "#N3416", i, nr); i <- i + 1
draw.vf.cell2("#J3454", "#N4750", i, nr); i <- i + 1
draw.vf.cell2("#J3456", "#N4949", i, nr); i <- i + 1
draw.vf.cell2("#J3458", "#N4958", i, nr); i <- i + 1
draw.vf.cell2("#J346f", "#N0994", i, nr); i <- i + 1
draw.vf.cell2("#J3470", "#N1098", i, nr); i <- i + 1
draw.vf.cell2("#J3476", "#N1496", i, nr); i <- i + 1
draw.vf.cell2("#J347c", "#N3785", i, nr); i <- i + 1
draw.vf.cell2("#J3521", "#N2379", i, nr); i <- i + 1
draw.vf.cell2("#J3522", "#N1582", i, nr); i <- i + 1
draw.vf.cell2("#J3524", "#N2480", i, nr); i <- i + 1
draw.vf.cell2("#J3525", "#N2507", i, nr); i <- i + 1
draw.vf.cell2("#J352d", "#N4318", i, nr); i <- i + 1
draw.vf.cell2("#J3530", "#N4610", i, nr); i <- i + 1
draw.vf.cell2("#J3534", "#N5276", i, nr); i <- i + 1
draw.vf.cell2("#J3535", "#N5445", i, nr); i <- i + 1
draw.vf.cell2("#J3546", "#N3981", i, nr); i <- i + 1
draw.vf.cell2("#J3555", "#N4685", i, nr); i <- i + 1
draw.vf.cell2("#J355a", "#N0154", i, nr); i <- i + 1
draw.vf.cell2("#J355b", "#N0885", i, nr); i <- i + 1
draw.vf.cell2("#J355d", "#N1560", i, nr); i <- i + 1
draw.vf.cell2("#J3565", "#N2941", i, nr); i <- i + 1
draw.vf.cell2("#J3566", "#N3314", i, nr); i <- i + 1
draw.vf.cell2("#J3569", "#N3496", i, nr); i <- i + 1
draw.vf.cell2("#J356d", "#N2852", i, nr); i <- i + 1
draw.vf.cell2("#J356e", "#N1051", i, nr); i <- i + 1
draw.vf.cell2("#J356f", "#N1387", i, nr); i <- i + 1
draw.vf.cell2("#J3575", "#N4109", i, nr); i <- i + 1
draw.vf.cell2("#J3577", "#N4548", i, nr); i <- i + 1
draw.vf.cell2("#J357b", "#N5281", i, nr); i <- i + 1
draw.vf.cell2("#J357e", "#N0295", i, nr); i <- i + 1
draw.vf.cell2("#J3621", "#N0431", i, nr); i <- i + 1
draw.vf.cell2("#J3626", "#N0581", i, nr); i <- i + 1
draw.vf.cell2("#J362d", "#N1135", i, nr); i <- i + 1
draw.vf.cell2("#J362f", "#N1571", i, nr); i <- i + 1
draw.vf.cell2("#J3635", "#N2052", i, nr); i <- i + 1
draw.vf.cell2("#J3636", "#N2378", i, nr); i <- i + 1
draw.vf.cell2("#J364a", "#N0103", i, nr); i <- i + 1
draw.vf.cell2("#J364b", "#N2305", i, nr); i <- i + 1
draw.vf.cell2("#J364c", "#N2923", i, nr); i <- i + 1
draw.vf.cell2("#J3651", "#N1065", i, nr); i <- i + 1
draw.vf.cell2("#J3661", "#N4671", i, nr); i <- i + 1
draw.vf.cell2("#J3662", "#N4815", i, nr); i <- i + 1
draw.vf.cell2("#J3664", "#N4855", i, nr); i <- i + 1
draw.vf.cell2("#J3665", "#N0146", i, nr); i <- i + 1
draw.vf.cell2("#J3671", "#N3128", i, nr); i <- i + 1
draw.vf.cell2("#J3675", "#N3317", i, nr); i <- i + 1
draw.vf.cell2("#J367e", "#N1386", i, nr); i <- i + 1
draw.vf.cell2("#J3738", "#N0449", i, nr); i <- i + 1
draw.vf.cell2("#J3739", "#N0534", i, nr); i <- i + 1
draw.vf.cell2("#J373e", "#N2937", i, nr); i <- i + 1
draw.vf.cell2("#J373f", "#N1077", i, nr); i <- i + 1
draw.vf.cell2("#J3741", "#N1589", i, nr); i <- i + 1
draw.vf.cell2("#J3742", "#N1602", i, nr); i <- i + 1
draw.vf.cell2("#J374f", "#N0195", i, nr); i <- i + 1
draw.vf.cell2("#J3750", "#N3523", i, nr); i <- i + 1
draw.vf.cell2("#J3757", "#N4312", i, nr); i <- i + 1
draw.vf.cell2("#J375a", "#N4620", i, nr); i <- i + 1
draw.vf.cell2("#J3767", "#N2412", i, nr); i <- i + 1
draw.vf.cell2("#J3768", "#N2509", i, nr); i <- i + 1
draw.vf.cell2("#J376a", "#N3313", i, nr); i <- i + 1
draw.vf.cell2("#J376b", "#N3540", i, nr); i <- i + 1
draw.vf.cell2("#J376c", "#N4205", i, nr); i <- i + 1
draw.vf.cell2("#J376e", "#N2169", i, nr); i <- i + 1
draw.vf.cell2("#J3777", "#N1045", i, nr); i <- i + 1
draw.vf.cell2("#J3824", "#N2868", i, nr); i <- i + 1
draw.vf.cell2("#J3826", "#N3180", i, nr); i <- i + 1
draw.vf.cell2("#J3828", "#N3543", i, nr); i <- i + 1
draw.vf.cell2("#J382b", "#N4284", i, nr); i <- i + 1
draw.vf.cell2("#J3833", "#N5220", i, nr); i <- i + 1

