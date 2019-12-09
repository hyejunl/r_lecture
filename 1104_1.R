## 3주차

## 데이터 조작, 데이터 정제 
## 시각화에 대한 내용(ggplot2)

## mpg data set을 이용해서 데이터 조작, 정제에 대한 내용을 학습해보아요.

## mpg data set을 이용하기 위해서 특정 package를 설치해 보아요!
install.packages("ggplot2") #package 설치
library(ggplot2) #package를 메모리에 로딩

str(mpg) #자료구조를 조사해 보아요!!
#Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	
class(mpg) #자료구조를 조사해 보아요!!
#[1] "tbl_df"     "tbl"        "data.frame"
## mpg는 table data frame형태
## 출력을 용이하게 하기 위한 형태이고 
## console 크기에 맞추어서 data frame을 출력

df<- as.data.frame(mpg) # mpg를 원래 data frame형태로 변환
df
class(df) #[1] "data.frame"

## 사용할 data frame을 준비했어요!!
## data frame의 column명을 알아보아요!!
ls(df) #컬럼명만 뽑아오기 (컬럼명을 오름차순 정렬해서 추출)

## mpg에 대한 document를 확인해서 column의 의미를 먼저 파악해야 해요!
help(mpg)
#r document mpg dataset 크롬에 검색해서 확인할 수도 있다
head(df) # 기본적으로 6개 출력
tail(df)

head(df,3) # 보고싶은 개수를 지정할 수 있어요, default는 6개
View(df) # View창을 통해 데이터를 확인!
dim(df) #data frame의 행의 갯수와 열의 갯수를 알려줌 [1] 234  11
nrow(df);ncol(df) #행의 갯수와 열의 갯수 찾기
length(df) # column의 갯수[1] 11 (vector의 length는 원소의 갯수)
str(df) #자료구조, 행의 갯수, 열을 갯수, 컬럼명, 데이터 타입...

summary(df) # 가장 기본적인 통계데이터를 추출
# rev()  : vector에 대해서 데이터를 역순으로 바꿔주는 함수

########################################################################
#plyr은 머릿속에서 지우고 dplyr을 사용하는 걸로...
## 데이터 조작( dplyr: 디플라이알 )
## data frame을 조작할 때 가장 많이 사용하는 package
## 속도에 강점 : C++로 구현되어 있어요!
## chaining이 가능해요 (%>%)
## dplyr이 제공하는 여러 함수를 이용해서 우리가 원하는 데이터를 추출

library(dplyr)
# 1. tbl_df() 
df
df <- tbl_df(df) #table data frame
df <- as.data.frame(df) #data frame
df

# 2. rename() # column의 이름을 변경할 수 있어요
# raw data를 이용할 경우 column명이 없을 때 column명을 새로 명시해서 사용해야 해요!
# 컬럼명에 대소문자가 같이 있는 경우 모두 소문자, 대문자로 변경해서 사용하면 편해요
# df의 컬럼명을 모두 소문자 혹은 대문자로 변경
# rename(df,
#        새로운 컬럼1 = 원래컬럼1)
names(df) = toupper(names(df))
df
ls(df)

new_df <- rename(df,
                 MODEL = model) #data frame을 리턴

head(new_df)

# 3. 조건을 만족하는 행을 추출하는 함수 
# filter(data frame,
#        조건1, 조건2, 조건3,...)
# mpg data set에서 2000년도에 생산된 차량이 몇개 있는지 추출
df <- as.data.frame(mpg)
nrow(filter(df,
            year == 2008))
# 모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량의 model명을 출력하세요.

mydf<- filter(df,
              cty > mean(df$cty))%>%
       select("model")
nrow(mydf)   # 전체 차량의 갯수는 118개
nrow(unique(mydf)) # 23개
# 주의 ! NA 값이 표함되어 있으면 값이 이상하게 떨어짐

avg_cty <- mean(df$cty, na.rm=T);avg_cty 
#na.rm=T :혹시 na가 있다면 그 na를 빼고 연산해 
unique(filter(df,
              cty > avg_cty)$model)

# 고속도로 연비가 상위 75% 이상인 차량을 제조하는 제조사는 몇개인지 추출하세요
summary(df$hwy)
length(unique(filter(df,
                    hwy >= 27.00)$manufacturer)) #[1] 9


quantile(df$hwy,0.75)
#quantile(Vector,상위 몇프로) 상위 몇% 찾는 함수

length(unique(filter(df,
                     hwy >= summary(df$hwy)[5])$manufacturer))
# summary가 vector이기 때문에 그 vector의 5번째 아이 뽑기

# 오토 차량중 배기량이 2500cc 이상인 차량 수는 몇개 인가요?
nrow(filter(df,
            grepl("auto",trans),  #문자열에 auto가 들어가면
            displ >= 2.5)) #[1] 125

library(stringr)
nrow(filter(df,
            str_sub(trans,1,4)=="auto", #1부터 4까지의 문자열이 auto인 것
            displ >= 2.5)) #[1] 125


nrow(filter(df,
            str_detect(trans,"auto"), #문자열에 auto가 들어가면
            displ >= 2.5)) #[1] 125


# str_detect(vector, "문자열") => 있으면 T, 없으면 F


# 4. arrange() : 정렬하는 함수
# arrange(data frame,
#         column1,  # 기본 정렬방식 : 오름차순
#         desc(column2))   #내림차순

#모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량의 model명을 출력하세요.
#단, 모델명을 오름차순으로 정렬해 추출하세요
avg_cty <- mean(df$cty, na.rm=T)
unique(filter(df, cty > avg_cty)%>%
       select(model)%>%
       arrange(model))

#chaining을 이용한 방식
df %>% filter(cty > mean(cty))%>%
  select(model)%>%
  unique()%>%
  arrange(model)

# 5. select() : data frame에서 원하는 column만 추출하는 함수
# select(data frame, column1, column2,...)

# 6. 새로운 column을 생성하려면 어떻게 해야 하나요?

# 도시연비와 고속도로 연비를 합쳐서 평균 연비 column을 만들어 보아요!
mutate(df,
       mean_rate= (cty+hwy)/2)


# 기본 R의 기능을 이용해서 column을 만들 수 있어요!
df$mean_rate = (df$cty + df$hwy) /2 
head(df)


#column을 추가할 때는 mutate()함수를 이용해요

df<- as.data.frame(mpg)
head(df)
new_df<-df %>% mutate(mean_rate = (cty+hwy)/2 )
head(new_df)

# 7. 통계량을 구해서 새로운 컬럼으로 생성하는 함수 : summarise()

# model명이 a4이고 배기량이 2000cc 이상인 차들에 대해 전체 평균 연비를 계산하세요!

#mydf1<- df%>% filter(model=="a4",
#                  displ >= 2.0)
#mean((mydf1$cty + mydf1$hwy)/2)


#mydf1<- df%>% filter(model=="a4",
#                     displ >= 2.0)
#summarise(mydf1,
#          mean = mean((cty+hwy)/2))


#df%>% filter(model=="a4",
#            displ >= 2.0)%>%
#summarise(mean = mean((cty+hwy)/2))

#summarise 안쓰고 계산해보기
result<- df%>% 
        filter(model=="a4",
               displ >= 2.0)%>%
        mutate(avg_rate = (cty+hwy)/2)
mean(result$avg_rate)

# summarise()를 이용해 보아요!
df %>% filter(model == "a4",
              displ >= 2.0) %>%
       summarise(avg_rate = mean(c(cty,hwy))) #1행 1열짜리 data frame을 얻을 수 있다 # vector값을 mean안에 넣어서 전체 평균을구한다.
#avg_rate
#1     23.3

df %>% filter(model == "a4",
              displ >= 2.0) %>%
  summarise(avg_rate = mean(c(cty,hwy)),
            hahaha = max(cty))

#   avg_rate hahaha
#1     23.3     21

# 8. group_by() :범주형 변수에 대한 grouping (남자별, 여자별, 제조사별)
df%>% filter(displ >= 2.0)%>%
  group_by(manufacturer)%>%  #제조사별로 grouping
  summarise(avg_rate = mean(c(cty,hwy))) #제조사별로 요약통계량

# 9. left_join(), right_join(), inner_join(), outer_join() 
# date frame의 결합

########################################################################

# 1. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.
# 4이하 5이상
#  11     12
df<-as.data.frame(mpg)
av_4<-df%>% filter(displ<=4)%>%
  summarise(under4_avg = mean(hwy))

av_5<-df%>% filter(displ>=5)%>%
  summarise(under5_avg = mean(hwy))

cbind(av_4,av_5)
#
df%>% filter(displ<=4 | displ>=5)%>%
  group_by(displ<=4)%>%
  summarise(avg=mean(hwy))
#
df %>% summarise("4이하"=mean((df%>% filter(displ<=4))$hwy),
                 "5이상"=mean((df%>% filter(displ>=5))$hwy))
df %>% summarise("4이하"=mean((filter(df,displ<=4))$hwy),
                 "5이상"=mean((filter(df,displ>=5))$hwy))
data.frame("4이하"=mean((filter(df,displ<=4))$hwy),
           "5이상"=mean((filter(df,displ>=5))$hwy))


# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 평균적으로 더 높은지 확인하세요.
df%>%filter(manufacturer%in% c("audi" ,"toyota"))%>% 
  group_by(manufacturer)%>%
  summarise(avg_cty = mean(cty))
  

# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.
#num3<-df%>% filter(manufacturer%in% c("chevrolet","ford","honda"))%>%
#  group_by(manufacturer)%>%
#  summarise(avg_hwy=mean(hwy))
#num3;mean(num3$avg_hwy)

df%>% filter(manufacturer%in% c("chevrolet","ford","honda"))%>%
  summarise(avg=mean(hwy))


# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.


df%>% filter(manufacturer=="audi")%>%
  arrange(desc(hwy))%>%
  head(5)


# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.
df%>% group_by(manufacturer)%>%
  filter(class=="suv")%>%
  summarise(fuel=mean(c(cty,hwy)))%>%
  arrange(desc(fuel))%>%
  head(5)



# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.
df%>%group_by(class)%>%
  summarise(avg_class=mean(cty))%>%
  arrange(desc(avg_class))


# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.
df%>% group_by(manufacturer)%>%
  summarise(manu_hwy=mean(hwy))%>%
  arrange(desc(manu_hwy))%>%
  head(3)%>%
  select(manufacturer)


# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

df%>%filter(class=="compact")%>%
  group_by(manufacturer)%>%
  summarise(cnt=n())%>%
  arrange(desc(cnt))
















