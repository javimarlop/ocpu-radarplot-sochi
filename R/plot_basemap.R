randomplot3 <- function(wdpaid=1500){

library(rgdal)
library(rgeos)

rpath = system.file("extdata",package="ocpuRadarplot")
segm2<-readOGR(lay='sfile2',dsn=rpath)
segm<-segm2[segm2$wdpaid==wdpaid,]

library(ggmap)
#library(maptools)

segments_ll <- spTransform(segm, CRS("+init=epsg:4326"))
data<-fortify(segments_ll)
gCentroid(segments_ll)->center

ggmap(get_map(location = c(lon = center@coords[1], lat = center@coords[2]),maptype = 'terrain', zoom = "auto",source=c('google')), extent = 'device') +
       geom_polygon(aes(x = long, y = lat, group=id), data = data, color ="white", fill ="orangered4", size = .2, alpha = .4)

}

randomplot4 <- function(wdpa_id=150028312){

library(rgdal)
library(rgeos)

rpath = system.file("extdata",package="ocpuRadarplot")
segm2<-readOGR(lay='sfile2',dsn=rpath)
segm<-segm2[segm2$wdpa_id==wdpa_id,]

library(ggmap)
#library(maptools)

segments_ll <- spTransform(segm, CRS("+init=epsg:4326"))
data<-fortify(segments_ll)
gCentroid(segments_ll)->center

ggmap(get_map(location = c(lon = center@coords[1], lat = center@coords[2]),maptype = 'terrain', zoom = "auto",source=c('google')), extent = 'device') +
       geom_polygon(aes(x = long, y = lat, group=id), data = data, color ="white", fill ="orangered4", size = .2, alpha = .4)

}
