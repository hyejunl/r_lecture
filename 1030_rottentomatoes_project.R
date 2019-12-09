install.packages("jsonlite")
install.packages("httr")
install.packages("rvest")
install.packages("stringr")
library(jsonlite)
library(httr)
library(rvest)
library(stringr)

html_page <- read_html("https://www.rottentomatoes.com/top/bestofrt/?year=2019")
title_nodes <- html_nodes(html_page, 
                          "td>a.unstyled.articleLink") 
title_nodes 

title_url <- html_attr(title_nodes,"href") #속성 갖고 오는 함수 

title <- html_text(title_nodes,trim=T) #제목 뽑았어 
title 

# page2로 들어가 
myurl <- "https://www.rottentomatoes.com" 
request_url<-str_c(myurl,title_url[1]) #일단 1위로 들어갔어->나중에 for문 
#request_url 

html_page2 <-read_html(request_url) 
rating_nodes <- html_nodes(html_page2, 
                           "div>strong.mop-ratings-wrap__text--small") 

user_ratings <- html_text(rating_nodes[2]) #user ratings 뽑았어 
user_ratings 

genre_nodes <- html_nodes(html_page2, 
                          "div.meta-value>a") 
genre_nodes2 <-genre_nodes[str_sub(html_attr(genre_nodes,"href"),2,7)=="browse"] 
#str_sub(html_attr(genre_nodes,"href"),2,7)=="browse" 

genre <- html_text(genre_nodes2) ##장르뽑아냈다 

genre
genre_v<-paste(genre,collapse=",")
genre_v

######################################################################################

user_ratings_v<-c()
genre_v<-c()
for (idx in 1:100){
  myurl <- "https://www.rottentomatoes.com" 
  request_url<-str_c(myurl,title_url[idx]) #일단 1위로 들어갔어->나중에 for문 
  #request_url 
  
  html_page2 <-read_html(request_url) 
  rating_nodes <- html_nodes(html_page2, 
                             "div>strong.mop-ratings-wrap__text--small") 
  
  user_ratings <- html_text(rating_nodes[2]) #user ratings 뽑았어 
  user_ratings2<- str_split(user_ratings,":")[[1]][2] 
  
  genre_nodes <- html_nodes(html_page2, 
                            "div.meta-value>a") 
  #mainColumn > section.panel.panel-rt.panel-box.movie_info.media > div > div > ul > li:nth-child(2) > div.meta-value > a:nth-child(1)  는 장르
  #mainColumn > section.panel.panel-rt.panel-box.movie_info.media > div > div > ul > li:nth-child(3) > div.meta-value > a:nth-child(1)  는 저자
  #:nth-child(idx)는 몇번째 자식
  genre_nodes2 <-genre_nodes[str_sub(html_attr(genre_nodes,"href"),2,7)=="browse"] 
  #str_sub(html_attr(genre_nodes,"href"),2,7)=="browse" 
  
  genre <- html_text(genre_nodes2) ##장르뽑아냈다 
  
  genre
  genre_s<-paste(genre,collapse=",")
  genre_s
  
  user_ratings_v<- c(user_ratings_v,user_ratings2)
  genre_v<-c(genre_v,genre_s)
  
  
}
df<- cbind(title,user_ratings_v,genre_v)

View(df)
df
write.csv(df,
          file="C:/lecture2/data/rottentomatoes.csv",
          row.names=F,
          quote=F)
