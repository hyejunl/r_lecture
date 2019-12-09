# R에서 JSON 데이터 처리
# Network을 통해서 JSON데이터를 받아서
# Data Frame으로 만들기 위해 새로운 package를 이용해보아요!

# 1. package 설치
install.packages("jsonlite")
install.packages("httr") #네트워크를 사용하기 위해 필요한 package
# 2. package를 사용하기 위해 loading작업필요 
library(jsonlite)
library(httr)

# 3. 문자열 처리하기 위한 package loading
library(stringr)

url <- "http://localhost:8080/bookSearch/search?keyword="

request_url <- str_c(url,
                     scan(what=character()))   
#str_c : 문자열 붙이는 함수 ,scan() : 입력 받는 함수

request_url <-  URLencode(request_url)  #특정형식으로 해당 문자열을 바꿔주겠다 (한글처리)

request_url    #[1] "http://localhost:8080/bookSearch/search?keyword=java"
#검색어에 영어 입력해야 함
#한글 여행 인코딩 한 후 [1] "http://localhost:8080/bookSearch/search?keyword=%EC%97%AC%ED%96%89"


#주소가 완성되었어요!!
df <- fromJSON(request_url)    #어디서부터 JSON 갖고와 라는 함수

df
View(df) # df를 한눈에 보이도록 끌어올 수 있다.
str(df) # str(): df에 대한 정보를 알려줌/ 12개의 행, 4개의 열/ $이라는 컬럼들 /그 컬럼 안의 datatype
names(df) #df의 컬럼명 알아보는 함수 : [1] "img"    "title"  "author" "price" 

# 찾은 도서 제목만 console에 출력!
df[,2]
df$title[1]

for(idx in 1:nrow(df)){ #idx를 1부터 df의 행 갯수만큼 돌린다
  print(df$title[idx])              #vector형태로 열을 끌고옴
}

# JSON을 이용해서 Data Frame을 생성할 수 있어요
# data frame을 csv형식으로 file에 저장

write.csv(df,
          file="C:/lecture2/data/book.csv",
          row.names = FALSE, #row에 숫자로 되어있는 놈은 사용하지 않겠어
          quote=FALSE) #""사라짐 -> 주의 책 이름에 ,가 있으면 프로그램 처리할 때 문제가 생길 수도 있음

# Data Frame을 JSON형태로 변경하려면 어떻게 하나요?
df_json <- toJSON(df)
df_json
# [{"img":"http://image.hanbit.co.kr/cover/_m_4021m.gif","title":"IT CookBook, C++ 하이킹 : 객체지향과 만나는 여행","author":"성윤정, 김태은","price":"25000"},{"img":"http://image.hanbit.co.kr/cover/_m_5101m.gif","title":"게스트하우스 창업 A to Z : 청춘여행자의 낭만적 밥벌이","author":"김아람","price":"15000"},{"img":"http://image.hanbit.co.kr/cover/_m_5110m.gif","title":"크로아티아의 작은 마을을 여행하다 : 자다르의 일몰부터 두브로브니크의 붉은 성벽까지","author":"양미석","price":"15800"},{"img":"http://image.hanbit.co.kr/cover/_m_5001m.gif","title":"도쿄의 오래된 상점을 여행하다 : 소세키의 당고집부터 백 년 된 여관까지","author":"여지영, 이진숙","price":"15000"}]
prettify(df_json) #JSON을 구조화시켜서 이쁘게 만들어 준다.보기는 편하지만 사이즈가 커짐-> 그래서 file로 저장할 때는 순수json을 저장하는 경향이 높다

write(df_json,
      file="C:/lecture2/data/book_json.txt")

###########################################################################

# 2018년 10월 30일 박스오피스 순위를 알아내서 제목과 누적관람객수를 CSV파일로 저장하세요!
# 얻어온 데이터에서 필요한 내용만 추출해서 Data Frame을 새로 생성한 후 파일 출력
# Data Frame에서 로직처리(for문)해서 데이터를 추출해서 text 파일에 append해서 파일출력


urlBox<-"http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="
code<-"b6a192e90e17ef48feb1ca310e1bd18e"
date<-"&targetDt=20181030"
request_url<-str_c(urlBox,code,date)

dfBox<-fromJSON(request_url)
dfBox

#1. data frame으로 뽑아와서 붙이기
mydfBox <-dfBox$boxOfficeResult$dailyBoxOfficeList[c("movieNm","audiAcc")]


write.csv(mydfBox,
          file="C:/lecture2/data/boxoffice.csv",
          row.names=FALSE)

#2. for문과 append를 이용해서 붙이기
#vector=c()
#append(vector,1)
# append(벡터,값) :벡터에 값을 붙여갈게



#3. 파일 저장을 해서 append를 이용해서 파일에 가져다가 붙이기


##########################################################################

# Web Crawling : 인터넷 상에서 필요한 정보를 읽어와서 수집하는 일련의 작업(과정)

# Web scraping
# => 하나의 web page에서 내가 원하는 부분을 추출하는 행위
# Web crawling(web spidering) : 
# 자동화 봇인 crawler가 정해진 규칙에 따라 복수개의 web page를 browsing하는 행위 

# scraping을 할 때 CSS(jQuery) selector를 이용해서 필요한 정보를 추출
# selector를 이용해서 추출하기 힘든놈들도 있어요!
# 추가적으로 xpath도 이용해 볼거에요.(xml기반의 다른 표현)

# 특정 사이트에 접속해서 내가 원하는 데이터를 추출해보아요!!

# 1. 서버로부터 받은 HTML 태그로 구성된 문자열을 자료구조화시키는 패키지를 이용해야해요!

install.packages("rvest")
library(rvest)
library(stringr)

# 2. url을 준비해요!
url<- "https://movie.naver.com/movie/point/af/list.nhn"
page<-"page="

request_url<-str_c(url,"?",page,1)
request_url

# 3. 준비된 URL로 서버에 접속해서 HTML을 읽어온 후 자료구조화 시켜요!
html_page <- read_html(request_url) #html을 읽는 함수
html_page

# 4. selector를 이용해서 추출하기 원하는 요소(element)를 선택해요!
#원하는 요소 찾는 함수
nodes <- html_nodes(html_page,
                    "td.title > a.movie")  #td면서 class가 title인거의 자식으로 있는 a이면서 class가 movie인 것   (**:first로 가져오면 안됨)
nodes

# 5. tag사이에 들어있는 text를 추출해요!
title <- html_text(nodes,trim=TRUE) # node.text :jQuery에서 사용
                          # html_text : 태그 사이의 글자 가져옴

# 6. selector를 이용해서 리뷰 요소(element)를 선택해요!!
nodes <- html_nodes(html_page,
                    "td.title") #td면서 class가 title
review <- html_text(nodes,trim=TRUE) #trim은 앞 뒤 공백 제거
review
class(review) #[1] "character" :txt는 vector다


# 7. 필요없는 문자들을 제거
review <- str_remove_all(txt,"\t") #특정 패턴에 맞는 문자열을 지움
review <- str_remove_all(txt,"\n")
review <- str_remove_all(txt,"신고") #주의 : 글 내용에 신고가 들어가면 지워짐=>프로그램을 이용해서 마지막에 나오는 신고를 지울 수 있다. (가능하다면 만들어보렴 ㅎㅎ)
review #제목이랑 내용이 붙어서 출력되는 문제가 발생

# 8. 영화제목과 리뷰에 대한 내용을 추출
df = cbind(title,review)
View(df)

# 9. 이렇게 구축한 데이터를 파일에 저장해요!


########################################################################

### 이번에는 같은 작업을 xpath를 이용해서 처리해보아요!!

install.packages("rvest")
library(rvest)
library(stringr)

url<- "https://movie.naver.com/movie/point/af/list.nhn"
page<-"page="

request_url<-str_c(url,"?",page,1)
request_url

html_page <- read_html(request_url) #html을 읽는 함수

nodes <- html_nodes(html_page,
                    "td.title > a.movie")
title <- html_text(nodes,trim=TRUE)

# Review부분은 xpath로 가져와 보아요!

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

df = cbind(title,review)
View(df)

########################################################################

# 반복해서 page를 browsing하는 crawling까지 포함해보아요!

extract_comment <- function(idx){
  url<- "https://movie.naver.com/movie/point/af/list.nhn"
  page<-"page="
  
  request_url<-str_c(url,"?",page,idx)
  html_page <- read_html(request_url, encoding = "CP949")
  #request_url
  
  
  nodes <- html_nodes(html_page,
                      "td.title > a.movie")
  title <- html_text(nodes,trim=TRUE)
  
  # Review부분은 xpath로 가져와 보아요!
  
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
  ##review
  
  df = cbind(title,review)
  return(df)
}
####함수를 호출해서 crawling을 해보아요!!

result_df <- data.frame();
for(i in 1:10) {   
  tmp <- extract_comment(i)
  result_df <- rbind(result_df,tmp)

  }#10개의 페이지를 반복적으로 땡김


View(result_df)










