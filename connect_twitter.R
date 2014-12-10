# pre-requisites
install.packages('bitops')
install.packages('RCurl')
install.packages('tm')
install.packages('maps')
install.packages('ggplot2')
install.packages('devtools')
devtools::install_github('hadley/httr')
devtools::install_github('geoffjentry/twitter')
install.packages('streamR')
install.packages('ROAuth')

requestURL <-  "https://api.twitter.com/oauth/request_token"
accessURL =    "https://api.twitter.com/oauth/access_token"
authURL =      "https://api.twitter.com/oauth/authorize"
consumerKey <- "xxx"
consumerSecret <- "yyy"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=requestURL,
                             accessURL=accessURL,
                             authURL=authURL)
#download.file(url="http://curl.haxx.se/ca/cacert.pem",
#              destfile="cacert.pem")

#download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

twitCred$handshake(cainfo="cacert.pem")
save(list="twitCred", file="twitteR_credentials")

