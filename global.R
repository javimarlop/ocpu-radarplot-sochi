#library(shiny)
getMedalCounts = function(){
library(reshape2)

#load('data.RData')
hri<-read.table('hri_results.csv',sep=' ',header=T,dec='.')
# Export segments shapefile table to csv (QGIS) as db.csv and import it in R
db<-read.table('db.csv',sep=',',header=T)
# merge with segmentation output shapefile table
names(db)<-c('cat','label','wdpa_id','wdpaid')
duplicated(db$wdpaid)->dupl_index
db0<-db[!dupl_index,]
# normalize values by ECO/variable
hri0<-merge(hri,db0,by='wdpaid')
names(hri0)[30:38]<-c("Tree_cover","EPR", "Precipitation","Biotemperature","Slope","NDWI","NDVI_MAX","NDVI_MIN","GRASSLAND_cover")
ecos<-unique(hri0$ecoregion)

hri22<-hri0[,c(1:2,30:38,41)]
hri_ecos<-hri22[1,]
hri_ecos[1,]<-NA

for (k in 1:length(ecos)){

index<-hri0$ecoregion==ecos[k]

hri2<-hri22[index,]
hri2eco<-hri2

for (h in 3:11){
hri2eco[,h]<-hri2[,h]/max(hri2[,h])
}

hri_ecos<-rbind(hri_ecos,hri2eco)

#pas<-unique(hri2eco$wdpa_id)

#for (j in 1:length(pas)){
#index2<-hri2eco$wdpa_id==pas[j]
#hri2pa<-hri2eco[index2,1:10]
#}
#hri3<-melt(hri2pa,'wdpaid')
#names(hri3)<-c('className','axis','value')

}

data<-hri_ecos[-1,]
rm(db,db0,dupl_index,ecos,h,hri,hri_ecos,hri0,hri2,hri22,hri2eco,index,k)
return(data)
}
###
#runApp('.')
