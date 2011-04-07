#!/bin/bash -x
R=/home/hornerj/R-sources/branches/R-2-7-branch/bin/R
(cd ..; MINGSWFDEBUG=1 $R CMD INSTALL MingSWF)
$R --no-save --args $1 < inst/test1.R
