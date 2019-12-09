
# kakao API(이미지검색)를 이용해서 이미지를 찾고 파일로 저장해 보아요!

# 사용하는 package는 network연결을 통해서 서버에 접속해서 결과를 받아올 때 일반적으로 많이 사용하는 package를 이용

install.packages("httr")
library(httr)
library(stringr)

# Open API의 주소를 알아야 호출하죠!!
url <- "https://dapi.kakao.com/v2/search/image"

keyword <- "query=아이유"

request_url<- str_c(url,
                    "?",   #"?"있어야지 url에 검색어 연결이 된다
                    keyword)

request_url <-  URLencode(request_url)  #특정형식으로 해당 문자열을 바꿔주겠다 (인코딩->한글처리)
request_url # [1] "https://dapi.kakao.com/v2/search/image?query=%EC%95%84%EC%9D%B4%EC%9C%A0"   API 호출 주소를 만들었어요!!

# Open API를 사용할 때 거의 대부분 인증절차(key를 발급 받아야 함)를 거쳐야 사용할 수 있어요!
apikey <- "6a8c4ad6d1641d2379aecd8061a9ada6"

# Web에서 클라이언트가 서버쪽 프로그램을 호출할 때 호출방식이라는게 있어요!
# GET, POST, PUT, DELETE (기본적으로 4가지 방식)
# GET, POST를 이용
# GET방식 : 서버 프로그램을 호출할 때 전달 데이터를 URL뒤에 붙여서 전달
# ->data 사이즈에 제한이 있다 (대용량 데이터는 처리가 안됨)
# POST방식 : 서버 프로그램을 호출할 때 전달 데이터가 request header에 붙어서 전달
#인증이 없으면 fromjson을 사용했지만, 인증절차로 header에 인증코드를 넣어야 할때는 fromjson대신에 httr패키지의 get을 사용해서 가져온 것이다. 

##reference: getdata<-GET(url=query, add_headers(Authorization="bearer <your api key>"))
result<- GET(request_url,
             add_headers(
               Authorization=paste("KakaoAK",apikey)))   #httr package 안에 있는 함수

http_status(result) #접속상태 결과 **result가 df가 아니라 응답 객체로 떨어짐 그래서 content함수를 한번더 이용해야 함 **status는 접속상태 확인하는 함수

result_data <- content(result)  #httr 패키지 안의 함수 -> 결과를 추출
result_data

View(result_data)



for(i in 1:length(result_data$documents)){
  req<-result_data$documents[[i]]$thumbnail_url
  res<-GET(req) #이미지에 대한 응답** get은 url을 전달하는 것
  #결과로 받은 이미지를 raw형태로 추출
  imgData= content(res,"raw") #이미지 파일에 대한 내용을 들고옴 (image는 binary파일 -> 문자열과 다르게 처리해야 함"raw"라고 type설정)**content는 데이터를 불러 오는 것
  writeBin(imgData,
           paste("C:/lecture2/image/img",
           i,         #image까지가 폴더, img가 파일명 앞부분
           ".png"))    #확장자명
  #binary파일을 writing할거야
  
}

########################################################################
#Selenium을 이용한 동적 page scraping (페이지 자체에는 데이터가 없고 사용자가 뭔가를 해야지 데이터가 생기는 경우)

#Selenium을 R에서 사용할 수 있도록 도와주는 package를 설치해야 해요!
install.packages("RSelenium")
library(RSelenium)

# R 프로그램에서 Selenium Server에 접속한 후 remote driver객체를 return 받아요!

remDr<-remoteDriver(remoteServerAddr="localhost",
             port=4445,
             browserName="chrome") 
#R 프로그램이 selenium server에 접속하기 위한 함수 **같은 컴퓨터의 sever다 localhost
remDr
# 접속이 성공하면 remote driver를 이용해서 chrome browser를 R code로 제어할 수 있어요!

# browser Open
remDr$open() #브라우저 열라는 얘기

# open된 browser의 주소를 변경해요!
remDr$navigate("http://localhost:8080/bookSearch/index.html")

# 프로그램이 자동으로 입력하고 검색하도록 (input박스찾기)
inputBox<-remDr$findElement(using="css",
                  "[type=text]") 
# using = xpath로 찾을거야 css로 찾을거야??

# 찾은 입력상자에 검색어를 넣어요!
inputBox$sendKeysToElement(list("여행")) #key값을 input 상자 안에 넣어라
#값을 여러개 넣을 수 있기 때문에 list로 넣는다

# AJAX호출을 하기 위해 버튼을 먼저 찾아야 해요!
btn <- remDr$findElement(using="css",
                         "[type=button]") 

# 찾은 버튼에 click event를 발생
btn$clickElement()

# AJAX 호출이 발생해서 출력된 화면에서 필요한 내용을 추출 
#copy한 selector #myList > li:nth-child(1)
li_element = remDr$findElements(using="css",
                               "li") 
# 이렇게 얻어온 element 각각에 대해서 함수를 호출
myList <- sapply(li_element,function(x){
  x$getElementText()        #list형태로 데이터가 출력됨
})
  


for(i in 1:length(myList)){
  print(myList[[i]])
}









  
  

