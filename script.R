#data<-read.table('hri_results.csv',sep=' ',header=T)
library(shiny)
load('data.RData')
library(reshape2)
data<-data[,-(3:29)]
data[data$PA %in input$PA_filter1,]->data2
as.data.frame(t(data2[,3:11]))->data3
as.character(data2$wdpaid)->names(data3)



