MingSWF <- function(file="Rplot.swf", height=400, width=400, scale=20,version=8, bg="white",fonts=NULL)
{
	rv <- .Call("MingSWFNew", file, height, width, scale, version, bg, fonts,initAS=NULL,label=NULL)
	if (is.null(rv)) stop("Unable to start MingSWF device")
	invisible(rv)
}

MingSWFdebugLabel <- function(type,numCalls,args,dispHist){
}
