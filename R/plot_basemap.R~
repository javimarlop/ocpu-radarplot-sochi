randomplot3 <- function(wdpaid){

library(rgdal)
rpath = system.file("extdata",package="ocpuRadarplot")
segm<-readOGR(lay='sfile2',dsn=rpath)
#plot(sfile[sfile$wdpaid==wdpaid,],col=sfile$wdpa_id)

library(ggmap)
#library(ocpuRadarplot)
#library(maptools)

#segm<-readOGR(dsn='inst/extdata',lay='sfile2')
#segm2 <- readShapeSpatial('inst/extdata/sfile2', proj4string = CRS("+init=epsg:54009"))

segments_ll <- spTransform(segm, CRS("+init=epsg:4326"))
data<-fortify(segments_ll)


p<-ggmap(get_map(location = c(lon = data$long[1], lat = data$lat[1]),maptype = 'roadmap', zoom = 7,source=c('google')), extent = 'device') +
       geom_polygon(aes(x = long, y = lat), data = data, colour = 'red', fill = 'red', alpha = .2)
print(p)
}
