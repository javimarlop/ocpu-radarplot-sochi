#' Make a random plot
#' 
#' This function creates a random histogram plot.
#' 
#' @export
#' @param n numer of random values 
#' @param dist one of "normal" or "uniform".
#randomplot <- function(n, dist=c("normal", "uniform")){
#  #input validation
#  dist <- match.arg(dist)
#  stopifnot(n < 1e6)
  
#  if(dist == "normal"){
#    hist(rnorm(n))
#  }
  
#  if(dist == "uniform"){
#    hist(runif(n))
#  }
  
#  #return nothing
#  invisible();  
#}

randomplot2 <- function(wdpaid){
  #dataf = getMedalCounts(ecoregion,wdpaid)
  #plot(dataf[1,])
  plot(1:wdpaid)
  
}

randomplot3 <- function(wdpaid){

library(rgdal)
rpath = system.file("extdata",package="ocpuRadarplot")
sfile<-readOGR(lay='sfile2',dsn=rpath)
plot(sfile[sfile$wdpaid==wdpaid,],col=sfile$wdpa_id)
  
}


