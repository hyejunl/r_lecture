install.packages("jsonlite")
install.packages("httr")
install.packages("stringr")
install.packages("rvest")
library(jsonlite)
library(httr)
library(stringr)
library(rvest)



url<- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=179482&target=after&page="


request_url<-str_c(url,1)
request_url


html_page <- read_html(request_url,encoding="CP949") #html을 읽는 함수



review = vector(mode="character",length=10)
for(idx in 1:length(title)){
  mypath <- str_c('//*[@id="old_content"]/table/tbody/tr[',
                  idx,
                  ']/td[2]/text()')


nodes <- html_nodes(html_page,
                    xpath=mypath)

#nodes <- html_nodes(html_page,
#                    xpath='//*[@id="old_content"]/table/tbody/tr[1]/td[2]/text()') #""쓰면 안에것 때문에 짤리기 때문에 ''를 사용하면 된다.
          # xpath에서는 자식selector로 /을 사용함
          # [i] i번째

txt <- html_text(nodes,trim=TRUE) #3번째 vector에만 내용이 들어있음
review[idx] <- txt[3] #3번째것만 vector access

}
review
View(review)

View(df)

########################################################################

# 반복해서 page를 browsing하는 crawling까지 포함해보아요!

extract_comment <- function(idx){
 
  
  url<- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=179482&target=after&page="
  
  
  request_url<-str_c(url,idx)
  html_page <- read_html(request_url, encoding = "CP949")
  #request_url
  
  

  
  # Review부분은 xpath로 가져와 보아요!
  
  review = vector(mode="character",length=10)
  for(idx in 1:10){
    mypath <- str_c('//*[@id="old_content"]/table/tbody/tr[',
                    idx,
                    ']/td[2]/text()')
    
    
    nodes <- html_nodes(html_page,
                        xpath=mypath)
    
    #nodes <- html_nodes(html_page,
    #                    xpath='//*[@id="old_content"]/table/tbody/tr[1]/td[2]/text()') #""쓰면 안에것 때문에 짤리기 때문에 ''를 사용하면 된다.
    # xpath에서는 자식selector로 /을 사용함
    # [i] i번째
    
    txt <- html_text(nodes,trim=TRUE) #3번째 vector에만 내용이 들어있음
    review[idx] <- txt[3] #3번째것만 vector access
    
   }
  return(review)
}
####함수를 호출해서 crawling을 해보아요!!

result_v <- c();
for(i in 1:30) {   
  tmp <- extract_comment(i)
  result_v<-c(result_v,tmp)

  }#10개의 페이지를 반복적으로 땡김


View(result_v)


################ result_v로 벡터 뽑아옴

install.packages("rJava")
library(rJava)
install.packages("KoNLP")
library(KoNLP)
result_v<- str_replace_all(result_v,
                      "\\W"," ") #특수문자의 정규표현식 "\\W"
useNIADic()
nouns <- extractNoun(result_v)
#head(nouns)

words<-unlist(nouns)
wordcloud <- table(words)
df <- as.data.frame(wordcloud,
                    stringsAsFactors = F)
View(df)
####### 뽑아낼데이터만 거르기
library(dplyr)
word_df <- df%>%
  filter(nchar(words)>=2)%>% #nchar은 문자열의 글자 갯수를 구하는 함수
  arrange(desc(Freq))%>% #빈도수가 높은 순서대로 정렬
  head(100) #상위 20개
#View(word_df)

install.packages("wordcloud")
library(wordcloud)  
pal <- brewer.pal(8,"Dark2")

#word_df
wordcloud(words=word_df$words, # 사용할 단어의 list를 벡터형태로 
          freq=word_df$Freq,
          min.freq=15,    
          max.words=30, # 최대 단어수는 50개
          random.order=F,# 최고빈도 단어를 중앙 배치 (단어의 위치를 random하게 할까?)
          rot.per = .15, #글자를 회전하는 비율(옆으로 나오게 하는거 0.1)
          scale=c(7,0.7), #단어 크기 비율(큰거는 4, 작은거는 0.3)
          color=pal) #단어 색깔은 pal잡을 걸루

