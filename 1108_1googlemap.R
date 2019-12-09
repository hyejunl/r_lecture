# 구글 지도 서비스를 이용해 보아요!

# Google Map Platform을 사용하기 위해서는 특정 package가 필요해요!

# 이 package가 CRAN에 등록이 아직 안되어 있어요!
# github에 공유되어 있어요!

# VCS( Version Control System )

# 원본 : A
# 홍길동 : A1
# 최길동 : A2

## 이런 공동작업에 대한 문제를 해결하기 위해서 나온게 VCS
## CVCS( Centralized VCS )
## 소스 원본을 중앙서버가 1개 들고 있고 나머지 사람이 복사본을 가져다가 작업
## 서버문제에 따라서 작업에 차질 

## DVCS( Distributed VCS )
## 소스 원본을 여러곳에서 보관
## Git을 이용하면 공동처리가 쉬워져요!
## Git repository(저장소)
## 이런 Git Repository를 서비스 해주는 회사가 있어요 => Github

###############################################################

# 1. Github에 공유되어 있는 ggmap package를 설치해야 해요!

# 버전 특성을 타요!
# package들은 dependency(의존성)에 신경써야 해요
# 현재 R 버전을 확인해보아요!
sessionInfo() #R version 3.6.1 (2019-07-05) 

# google에 cran 들어가서 ->Other builds-> Previous releases ->R 3.5.1 (July, 2018) 다운로드 -> 시작메뉴 폴더만 R-3.5.1로 바꿔주고 나머지는 그냥 다음다음 해서 깔기 -> r 껐다가 키면은 version 3.5.1로 바뀌어 있음

# 현재 R 버전이 3.6.1이에요.. 그런데 사용하려는 package가 3.5.1버전에서 실행되요!

# 이제 버전을 맞췄으니 필요한 package를 github에서 다운받아 설치해 보아요!

install.packages() # CRAN에서 받아서 설치
install.packages("devtools")
library(devtools)
install_github("dkahle/ggmap") #이놈을 이용하기 위해서 dextools 패키지 먼저 설치
library(ggmap)
#https://cloud.google.com/maps-platform/terms/ -> 로그인하고 get start->maps

# 생성한 구글 API Key
key_t = "AIzaSyDb8Oqv9AqTVBFWUKyOZh1SkSv_9SeEtKI" #선생님 key
googleAPIKey = "AIzaSyBlxzwHJxYYtneVllnd2rsGzxIVEHVm5uE"

# 구글 API Key를 이용해서 인증을 받아요!
register_google(key=googleAPIKey)

gg_seoul <- get_googlemap("seoul", 
                          maptype = "roadmap") 
ggmap(gg_seoul)

library(dplyr)
library(ggplot2)

geo_code = geocode(enc2utf8("공덕역")) #인코딩 to utf-8 #위도 경도 알아보기
geo_code # table형태

# google map을 그리려면 위도,경도가 숫자형태의 vector로 되어 있어야 해요!

geo_data = as.numeric(geo_code) # 값이 두개라서 vector로 됨
geo_data

get_googlemap(center=geo_data, #이 위도 경도를 지도의 중앙으로 잡아  
              maptype = "roadmap",
              zoom=16)%>%   #지도 확대 표현, %>%를 사용해서 넘길 수있음
  ggmap() + #+로 그래프 지도 위에 그릴 수 있음
  geom_point(data=geo_code, #table형태의 data를 줘야 함
             aes(x=lon,
                 y=lat),
             size=5,
             color="red")

##################################################################### 
addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr)) #벡터로 만들어서 위도경도 땡기기기  
gc  

#df2<-as.data.frame(gc) #table로 되어있는 결과값을 데이터 프레임으로 바꿔줘야 함
#df2

df <- data.frame(lon=gc$lon,
                 lat=gc$lat)  
df  

cen <- c(mean(df$lon),mean(df$lat))  

map<-get_googlemap(center=cen,
              maptype = "roadmap",
              zoom=13,
              markers = gc) #표시 찍는 함수  

result<- ggmap(map)


# 지하철역 주변 아파트 정보 : 서울 열린 데이터 광장

# 아파트 실 거래 금액 데이터 : 국토부 실거래가 공개 시스템

############################################################

# interactive Graph

# package 설치
install.packages("plotly")
library(plotly)

# mpg data set을 이용해서 배기량과 고속도로 연비에 대한 산점도를 그려보아요!
library(ggplot2)

df<-as.data.frame(mpg)
head(df)

ggplot(data=df,
       aes(x=displ,
           y=hwy))+
  geom_point(size=3,
             color="blue")

ggplotly(g)  #마우스를갖다 대면 point값이 나오고 드래그 하면 확대되고 더블클릭하면 원래대로 돌아감, html로 저장도 가능함



ggplotly(result)

################### 확대, 값 확인

#### 시계열 그래프

#### 시간에 따른 선그래프는 단순 확대만으로는 사용이 힘들어요

#### 특정 구간에 대한 자세한 사항을 보기 위해서 다른 package를 이용

install.packages("dygraphs")
library(dygraphs)

# 예제로 사용할 data set은 economics

# 시계열 그래프는 데이터를 xts라는 형식으로 변환시켜줘야 해요!

# 시간에 따른 개인 저축률 변화 추이를 선 그래프로 그릴거에요

ggplot(data=economics,
       aes(x=date,
           y=psavert))+
  geom_line()

library(xts)

save_rate <- xts(economics$psavert, #economics 안의 psavert를 xts라는 특수한 시간 형식으로 변환시킬거다
                 order.by=economics$date) #date 순서대로(시간순)

head(save_rate)

dygraph(save_rate)%>% #결과를 dynamic graph로 그려준다.
  dyRangeSelector() #아래의 bar를 조정해서 구간을 설정해서 볼 수 있다

#실업자수 추이
unemp_rate = xts(economics$unemploy/1000,   #단위가 안맞으면 데이터를 결합할 수 없기 때문에 단위를 맞춘 것
                  order.by=economics$date) 

unemp_save = cbind(save_rate,unemp_rate)
#시간데이터는 col이 아니기 때문에 하나의 col으로 되어있는 vector 2개를 합치는 것

dygraph(unemp_save)%>%
  dyRangeSelector() 

#################################################################









# MovieLens (정형)
# 로튼토마토 크롤링 (반정형)
# KAKAO API (반정형)
# 네이버 댓글 크롤링 후 워드클라우드(비정형)
# 패널데이터 실습 (정형)






















