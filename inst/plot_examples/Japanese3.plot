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

nr <- 26
nc <- 3
make.table(nr, nc)
i <- 0
draw.title("Kanji (1)", nc)
draw.vf.cell2("#J3021", "#N0043", i, nr); i <- i + 1
draw.vf.cell2("#J3026", "#N2829", i, nr); i <- i + 1
draw.vf.cell2("#J302d", "#N0062", i, nr); i <- i + 1
draw.vf.cell2("#J3035", "#N0818", i, nr); i <- i + 1
draw.vf.cell2("#J303f", "#N1802", i, nr); i <- i + 1
draw.vf.cell2("#J3045", "#N2154", i, nr); i <- i + 1
draw.vf.cell2("#J304c", "#N0401", i, nr); i <- i + 1
draw.vf.cell2("#J3057", "#N2107", i, nr); i <- i + 1
draw.vf.cell2("#J3059", "#N0138", i, nr); i <- i + 1
draw.vf.cell2("#J305b", "#N3008", i, nr); i <- i + 1
draw.vf.cell2("#J305e", "#N3579", i, nr); i <- i + 1
draw.vf.cell2("#J3061", "#N4214", i, nr); i <- i + 1
draw.vf.cell2("#J306c", "#N0001", i, nr); i <- i + 1
draw.vf.cell2("#J3070", "#N3294", i, nr); i <- i + 1
draw.vf.cell2("#J3078", "#N1026", i, nr); i <- i + 1
draw.vf.cell2("#J307a", "#N1562", i, nr); i <- i + 1
draw.vf.cell2("#J3122", "#N5006", i, nr); i <- i + 1
draw.vf.cell2("#J3126", "#N0878", i, nr); i <- i + 1
draw.vf.cell2("#J3127", "#N1280", i, nr); i <- i + 1
draw.vf.cell2("#J3129", "#N3673", i, nr); i <- i + 1
draw.vf.cell2("#J312b", "#N5042", i, nr); i <- i + 1
draw.vf.cell2("#J3132", "#N2629", i, nr); i <- i + 1
draw.vf.cell2("#J313b", "#N2973", i, nr); i <- i + 1
draw.vf.cell2("#J313f", "#N4725", i, nr); i <- i + 1
draw.vf.cell2("#J3140", "#N5046", i, nr); i <- i + 1
draw.vf.cell2("#J314a", "#N0130", i, nr); i <- i + 1
draw.vf.cell2("#J3155", "#N2599", i, nr); i <- i + 1
draw.vf.cell2("#J315f", "#N0617", i, nr); i <- i + 1
draw.vf.cell2("#J3173", "#N4733", i, nr); i <- i + 1
draw.vf.cell2("#J3176", "#N1125", i, nr); i <- i + 1
draw.vf.cell2("#J3177", "#N2083", i, nr); i <- i + 1
draw.vf.cell2("#J317e", "#N1504", i, nr); i <- i + 1
draw.vf.cell2("#J3221", "#N1885", i, nr); i <- i + 1
draw.vf.cell2("#J3223", "#N2361", i, nr); i <- i + 1
draw.vf.cell2("#J3226", "#N2922", i, nr); i <- i + 1
draw.vf.cell2("#J322b", "#N5399", i, nr); i <- i + 1
draw.vf.cell2("#J322f", "#N0551", i, nr); i <- i + 1
draw.vf.cell2("#J3235", "#N0260", i, nr); i <- i + 1
draw.vf.cell2("#J3239", "#N2634", i, nr); i <- i + 1
draw.vf.cell2("#J323b", "#N5110", i, nr); i <- i + 1
draw.vf.cell2("#J323c", "#N0009", i, nr); i <- i + 1
draw.vf.cell2("#J323d", "#N0350", i, nr); i <- i + 1
draw.vf.cell2("#J323f", "#N0409", i, nr); i <- i + 1
draw.vf.cell2("#J3241", "#N0422", i, nr); i <- i + 1
draw.vf.cell2("#J3243", "#N0716", i, nr); i <- i + 1
draw.vf.cell2("#J3244", "#N0024", i, nr); i <- i + 1
draw.vf.cell2("#J3246", "#N0058", i, nr); i <- i + 1
draw.vf.cell2("#J3248", "#N1311", i, nr); i <- i + 1
draw.vf.cell2("#J324a", "#N3272", i, nr); i <- i + 1
draw.vf.cell2("#J324c", "#N0107", i, nr); i <- i + 1
draw.vf.cell2("#J324f", "#N2530", i, nr); i <- i + 1
draw.vf.cell2("#J3250", "#N2743", i, nr); i <- i + 1
draw.vf.cell2("#J3256", "#N3909", i, nr); i <- i + 1
draw.vf.cell2("#J3259", "#N3956", i, nr); i <- i + 1
draw.vf.cell2("#J3261", "#N4723", i, nr); i <- i + 1
draw.vf.cell2("#J3267", "#N2848", i, nr); i <- i + 1
draw.vf.cell2("#J3268", "#N0050", i, nr); i <- i + 1
draw.vf.cell2("#J3272", "#N4306", i, nr); i <- i + 1
draw.vf.cell2("#J3273", "#N1028", i, nr); i <- i + 1
draw.vf.cell2("#J3323", "#N2264", i, nr); i <- i + 1
draw.vf.cell2("#J3324", "#N2553", i, nr); i <- i + 1
draw.vf.cell2("#J3326", "#N2998", i, nr); i <- i + 1
draw.vf.cell2("#J3328", "#N3537", i, nr); i <- i + 1
draw.vf.cell2("#J332b", "#N4950", i, nr); i <- i + 1
draw.vf.cell2("#J332d", "#N4486", i, nr); i <- i + 1
draw.vf.cell2("#J3330", "#N1168", i, nr); i <- i + 1
draw.vf.cell2("#J3346", "#N1163", i, nr); i <- i + 1
draw.vf.cell2("#J334b", "#N2254", i, nr); i <- i + 1
draw.vf.cell2("#J3351", "#N4301", i, nr); i <- i + 1
draw.vf.cell2("#J3353", "#N4623", i, nr); i <- i + 1
draw.vf.cell2("#J3357", "#N5088", i, nr); i <- i + 1
draw.vf.cell2("#J3358", "#N1271", i, nr); i <- i + 1
draw.vf.cell2("#J335a", "#N2324", i, nr); i <- i + 1
draw.vf.cell2("#J3364", "#N0703", i, nr); i <- i + 1
draw.vf.cell2("#J3424", "#N2977", i, nr); i <- i + 1
draw.vf.cell2("#J3428", "#N1322", i, nr); i <- i + 1

