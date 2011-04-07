library(MingSWF)
source('inst/plot_examples/driver.R')
example<-commandArgs(trailingOnly=TRUE)[1]
if (example=='plot.all'){
	cat('Creating ALL Plots\n')
	plot.all()
} else {
	cat('Creating ',example,'\n')
	example.plot(example)
}

