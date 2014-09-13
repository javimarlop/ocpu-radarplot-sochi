require(rCharts)
library(rgdal)

bike2<-readOGR(dsn='sfile3.json',lay='OGRGeoJSON')

L1 <- Leaflet$new()
L1$tileLayer(provider = 'Esri.WorldImagery') # Stamen.TonerLite
L1$set(height = 800, width = 1600)
L1$setView(c(40.73, -73.99), 14)
L1$geoJson(bike2,
  style = "#! function(feature) {
    var rgn2col = {1:'red',2:'blue',4:'green'};     
    return {
      color: rgn2col[feature.properties['wdpa_id']],
      strokeWidth: '1px',
      strokeOpacity: 0.5,
      fillOpacity: 0.2
    }; } !#",
)
