library(MingSWF)

example.plot <- function(example="plotmath1",exampledir='inst/plot_examples',savedir='inst/plots',...){
	cat('creating',example,"\n")
	sdir <- paste(savedir,'/',example,sep='')
	system(paste('mkdir -p ',sdir,sep=''))
	system(paste('cp test.html ',sdir,sep=''))
	MingSWF(file=paste(sdir,'/test.swf',sep=''),width=400,height=400,version=8,...)
	source(paste(exampledir,'/',example,'.plot',sep=''))
	dev.off()
	png(file=paste(savedir,'/',example,'/test.png',sep=''),width=400,height=400,...)
	source(paste(exampledir,'/',example,'.plot',sep=''))
	dev.off()
}

plot.all <- function(exampledir='inst/plot_examples',savedir='inst/plots'){
	sapply(
		gsub('.plot','',grep('.plot',readLines(pipe(paste("ls",exampledir))),value=TRUE,fixed=TRUE),fixed=TRUE),
		example.plot
	)
	gc()
}
