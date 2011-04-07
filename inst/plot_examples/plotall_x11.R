source('examples/driver.R')
system('mkdir plots_x11')
type=Sys.getenv('TYPE')
if (type == '') type='png'
type
cairo.plot.all(savedir='plots_x11',plotfun=cairo.example.plot.x11,type=type)
