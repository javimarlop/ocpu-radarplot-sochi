library(rgdal)

setwd('inst/extdata')
#rpath = system.file("extdata",package="ocpuRadarplot")
rpath='.'
segm2<-readOGR(lay='sfile2',dsn=rpath)

segments_ll <- spTransform(segm2, CRS("+init=epsg:4326"))

#writeOGR(segments_ll,rpath,'sfile_ll',dri="ESRI Shapefile")
writeOGR(segments_ll,rpath,'sfile_ll',dri="ESRI Shapefile")

system('ogr2ogr -f "GeoJSON" sfile3.json sfile_ll.shp')


sfile2<-readOGR(dsn='sfile3.json',lay='OGRGeoJSON') # map must be lat long
