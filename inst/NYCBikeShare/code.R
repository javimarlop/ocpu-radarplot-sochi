require(rCharts)
library(rgdal)

bike2<-readOGR(dsn='sfile3.json',lay='OGRGeoJSON')

L1 <- Leaflet$new()
L1$tileLayer(provider = 'Esri.WorldImagery') # Stamen.TonerLite
L1$set(height = 800, width = 1600)
L1$setView(c(-4, 137), 14)
L1$geoJson(regions)

L1
