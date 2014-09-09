getMedalCounts = function(ecoregion='10105',wdpa_id='1500'){
library(reshape2)
rpath = system.file("extdata",package="ocpuRadarplot")

#load('data.RData')
hri<-read.table(paste(rpath,'/hri_results.csv',sep=''),sep=' ',header=T,dec='.')
# Export segments shapefile table to csv (QGIS) as db.csv and import it in R
db<-read.table(paste(rpath,'/db.csv',sep=''),sep=',',header=T)
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

data4<-hri_ecos[-1,]
rm(db,db0,dupl_index,ecos,h,hri,hri_ecos,hri0,hri2,hri22,hri2eco,index,k)

	data4[data4$ecoregion %in% ecoregion,]->data2
    data2[data2$wdpa_id %in% wdpa_id,]->data7

	as.data.frame(t(data7[,3:11]))->data3
	as.character(data7$wdpaid)->names(data3)

#print(data3)
return(data3)
}


#require("shiny")
#require("rCharts")
#shinyServer(function(input, output) { 
#  passData <- reactive({
##    data <- data[data$Country %in% input$Country_filter1,]
##    rownames(data) = data$Year#data$NUTS_CODE
##    print(data)
##    data[,7:9]
#	#data<-data[,-(3:29)]
#	data[data$wdpa_id %in% input$wdpa_id_filter1,]->data2
#	as.data.frame(t(data2[,3:11]))->data3
#	as.character(data2$wdpaid)->names(data3)
#	print(data3)
#	data3
#  }) 
########################################################################################
#  #### Radar chart output 2
#  output$radar1 <- renderChart2({
sochiChart <- function(ecoregion, wdpa_id){
	dataf = getMedalCounts(ecoregion, wdpa_id)
    a<- rCharts:::Highcharts$new() 
    a$chart(type='line',polar=TRUE, width=600,height = 350)
    a$pane(size='90%')
    a$title(text= "Environmental Variables")
    a$xAxis(categories= rownames(dataf),tickmarkPlacement='on',lineWidth=0)
    a$yAxis(gridLineInterpolation='polygon',lineWidth=0,min=0)
    a$data(dataf,pointPlacement='off')   
    return(a)    
  }#)
#})

#output$table1 <- renderChart2({

saveChart <- function(ecoregion, wdpa_id){
  a <- sochiChart(ecoregion, wdpa_id)
  a$set(height = 700)
  a$save('output.html', cdn = T)
  return(invisible())
}

inlineChart <- function(ecoregion, wdpa_id){
  a <- sochiChart(ecoregion, wdpa_id)
  a$set(height = 650)
  paste(capture.output(a$show('inline')), collapse ='\n')
}
