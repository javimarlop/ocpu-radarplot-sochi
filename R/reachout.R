library(twitteR)
#library(maps)

#    reqURL <- "https://api.twitter.com/oauth/request_token"
#            accessURL <- "http://api.twitter.com/oauth/access_token"
#            authURL <- "http://api.twitter.com/oauth/authorize"
#            consumerKey <- "yyy"
#            consumerSecret <- "xxx"
#            twitCred <- OAuthFactory$new(consumerKey=consumerKey,
#                                         consumerSecret=consumerSecret,
#                                         requestURL=reqURL,
#                                         accessURL=accessURL,
#                                         authURL=authURL)
#    twitCred$handshake()

#            registerTwitterOAuth(twitCred)
load('twitteR_credentials')
setup_twitter_oauth(twitCred$consumerKey,twitCred$consumerSecret,twitCred$oauthKey,twitCred$oauthSecret)

geol<-read.table('geo3.csv',sep=' ',header=T)
#require(multicore) # install.packages('multicore',,'http://www.rforge.net/')

gttw0<-function(ltw0,nt=nt0,buf='100km',tx=tx0){#='and'
loc<-paste(geol$latitude[ltw0],geol$longitude[ltw0],buf,sep=',')
tmp<-NULL
#twListToDF(searchTwitter('virunga',geocode='29,-1.3,100km',n=200))->kk
tmp<-try(twListToDF(searchTwitter(tx,geocode=loc,n=nt0)))
rule<-is.data.frame(tmp)
#print(rule)
#print(dim(tmp))
#try(tmp[,18]<-NULL)
#try(print(dim(tmp)))
try(tmp[,17:18]<-try(rep(NA,dim(tmp)[1])))
#try(print(dim(tmp)))
if(rule){
#print(dim(tmp))
tmp[,17]<-rep(geol$longitude[ltw0],dim(tmp)[1])
tmp[,18]<-rep(geol$latitude[ltw0],dim(tmp)[1])
#print(dim(tmp))
ltw2<-dim(tmp)[1]
#print(ltw2)
#tmp2 <<- unlist(lapply(ltw2,addll))
for(i in 1:ltw2){
if(!is.na(tmp[i,15])){
tmp[i,15]->tmp[i,17]
tmp[i,16]->tmp[i,18]
}
}
return(tmp)
}
}

data0<-NULL
data<-NULL

#addll<-function(ltw20){
#tmp<-get(tmp)
#if(!is.na(tmp[ltw20,15])){
#tmp[ltw20,15]->tmp[ltw20,17]
#tmp[ltw20,16]->tmp[ltw20,18]
#}
#}

gttw<-function(ltw,nt=100,tx='ebola',np=50){ # np=75
tx0<<-tx
nt0<<-nt
#ltw<-seq(1,dim(geol)[1],d)#1:3
ltw<-sample(1:dim(geol)[1],np)
results<<-lapply(ltw,gttw0)#mclapply
data <<- do.call("rbind", results)
#ltw20<<-ltw2
tweets.df_ll<-data[,c(18,17,1)]
names(tweets.df_ll)<-c('lat','lng','text')
write.table(tweets.df_ll,'dynmaps/data/data.csv',sep='|',quote=F,row.names=F)
#fitw3<<-sum(unlist(results3),na.rm=T)/length(unlist(results3))
#return(results)
}

