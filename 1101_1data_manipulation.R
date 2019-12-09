# 데이터 분석업무에서
# raw data를 얻은 다음
# 머신러닝 모델링을 위해서 또는 시각화를 위해서 이 raw data를 적절한 형태로 변형
# 데이터 변환, 필터링, 전처리 작업이 필요해요!

# 이런 작업(데이터 조작)에 특화된 package들이 존재해요
# plyr => pliers + R => 패키지를 구현한 언어 R **데이터를 처리하는데 속도가 느리다
# dplyr => data frame + Pliers + R (디플라이알)
# vector나 data frame에 적용할 수 있는 기본 함수 

# 실습할 데이터가 필요해요!
# iris(아이리스) : R에 내장되어있는 데이터

View(iris)
# iris : 붓꽃의 종류와 크기에 대해 측정한 데이터 
# 통계학자 피셔라는 사람이 측정해서 제공
# 컬럼

help(iris)

ls(iris)
# Species : 종(3가지)
# Sepal.Length : 꽃받침의 길이
# Sepal.Width : 꽃받침의 너비
# Petal.Length : 꽃잎의 길이
# Petal.Width : 꽃잎의 너비

# 기본함수
# 1. head() : 데이터 셋의 앞에서부터 6개의 데이터를 추출해요
#             데이터 프레임이 아닌 경우에도 적용이 되요
head(iris)
#Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#1          5.1         3.5          1.4         0.2  setosa
#2          4.9         3.0          1.4         0.2  setosa
#3          4.7         3.2          1.3         0.2  setosa
#4          4.6         3.1          1.5         0.2  setosa
#5          5.0         3.6          1.4         0.2  setosa
#6          5.4         3.9          1.7         0.4  setosa
head(iris,n=3) #n을 정해주면 n만큼만 record 추출 (default는 n=6)
var<-c(1,2,3,4,5,6,7,8,9)
head(var) #[1] 1 2 3 4 5 6
help(head) # 이것을 통해 함수 사용의 reference를 확인해볼 수 있다

# 2. tail() : 데이터 셋의 뒤에서부터 6개의 데이터를 추출해요
#             데이터 프레임이 아닌 경우에도 적용이 되요
tail(iris,n=3) #n의 기본값은 6
#Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
#148          6.5         3.0          5.2         2.0 virginica
#149          6.2         3.4          5.4         2.3 virginica
#150          5.9         3.0          5.1         1.8 virginica

# 3. View() : View창에 데이터를 출력
# View창에서 위에 필터 누르고 그림으로 구간 잡아서 filtering할 수 있다
View(iris)

# 4. dim() : data frame에 적용할 때 행과 열의 개수를 알려줘요 (matrix에도 적용됨)
dim(iris) #[1] 150   5  -> 150행 5열
# 선형자료구조 (vector,list)에서는 사용할 수 없다 ->NULL로 나옴
var<-c(1,2,3,4,5,6,7,8,9)
dim(var) #NULL 
help(dim)

# 5. nrow() : data frame의 행의 개수
nrow(iris) #[1] 150 : 150개의 행, observation(관측값), row

# 6. ncol() : data frame의 열의 개수
ncol(iris) # [1] 5  :5개의 열, variation(변수),column

# 7. str() : data frame의 일반적인 정보를 추출
str(iris)
#'data.frame':	150 obs. of  5 variables:
#  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#$ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#$ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#$ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...   
# Factor w/ 3 levels => 3가지 범주의 데이터라는 뜻

# 8. summary() : data frame의 요약 통계량을 보여줘요!
# Min, Max, 사분위(1st Qu), 평균(mean),중간값(Median)
summary(iris)
#Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
#Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
#1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
#Median :5.800   Median :3.000   Median :4.350   Median :1.300  
#Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
#3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
#Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
#Species  
#setosa    :50  
#versicolor:50  
#virginica :50  

# 9. ls() : data frame의 column명을 vector로 추출, 오름차순으로 정렬(알파벳 순서대로)
ls(iris)
#[1] "Petal.Length" "Petal.Width"  "Sepal.Length" "Sepal.Width"  "Species"

# 10. rev() : 선형자료구조 데이터의 순서를 거꾸로 만들어요
rev(ls(iris))
#[1] "Species"      "Sepal.Width"  "Sepal.Length" "Petal.Width"  "Petal.Length"

# 11. length() : 길이를 구하는 함수 
#                data frame에 적용하면 column의 갯수를 알려줌
#                matrix에 적용하면 요소의 갯수를 알려줌
length(iris) #[1] 5   : data frame은 column의 갯수를 알려줌
var1<-matrix(1:12,ncol=3)
length(var1) #[1] 12  : matrix는 요소의 갯수를 알려줌

##########################################################################
# plyr package => dplyr 계량형 package
install.packages("plyr")
library(plyr) #require(plyr)

# 1. key값을 이용해서 두개의 data frame을 병합(세로방향, 열방향으로 결합)
# **r 패키지의 join 함수 사용**
# data frame을 두개 만들어 보아요 (plyr 패키지의 join 함수 사용)
x<- data.frame(id=c(1,2,3,4,5),
               height=c(150,190,170,188,167))
y<- data.frame(id=c(1,2,3,6),
               weight=c(50,100,80,78))
join(x,y,by="id",type="inner")  #x,y df를 "id" column을 기준으로 결합할거야 join 종류는 "inner"야    
# type 종류는 inner, left, right, full 있음. default값은 left join
# 데이터 빈 곳은 na값으로 나옴
join(x,y,by="id",type="inner")
join(x,y,by="id",type="left") #default
join(x,y,by="id",type="right")
join(x,y,by="id",type="full")
# key를 1개 이용해서 결합하는 걸 해보았어요!
# key를 2개 이상 이용해서 결합하는건?

x<- data.frame(id=c(1,2,3,4,5),
               gender=c("M","F","M","F","M"),
               height=c(150,190,170,188,167))
y<- data.frame(id=c(1,2,3,6),
               gender=c("F","F","M","F"),
               weight=c(50,100,80,78))

join(x,y,by=c("id","gender"),type="inner") #기준부분에 vector를 줌
#   id gender height weight      1번은 gender값이 다르기 때문에 빠짐
#1  2      F    190    100
#2  3      M    170     80

# dplyr에서는 join() => left_join() 이렇게 종류에 따라 함수를 따로 사용함

# 2. 범주형 변수를 이용해서 그룹별 통계량 구하기 
str(iris)
unique(iris$Species)  #중복배제하고 나머지 알려줘 #$사용해서 df의 col명시
#[1] setosa     versicolor virginica 
#Levels: setosa versicolor virginica
# iris의 종별 꽃잎 길이의 평균을 구하세요!
# tapply(대상 column,범주형 column, 적용할 함수)
# tapply는 한번에 1개의 통계만 구할 수 있어요. ex)평균과 max 값을 같이 구할거야X => 하나씩 따로 구해야 함. 같이 구하는건 불가능
tapply(iris$Petal.Length,
       iris$Species,
       FUN=mean)
# 꽃잎의 길이를 종을 기준으로 평균을 구할거야.
#setosa versicolor  virginica 
#1.462      4.260      5.552 
 

# 꽃잎의 길이를 종을 기준으로 평균과 표준편차를 구하세요. 하나씩 구해야함
# ddply() : 한번에 여러개의 통계치를 구할 수 있어요!
# ddply(대상 df,.(어떤것을 기준으로 할건지 column명),summarise,새로운 column명=mean(변수의 이름), 새로운 column명= sd(변수의 이름))
df<-ddply(iris,
      .(Species),
      summarise,
      avg=mean(Petal.Length),
      sd=sd(Petal.Length))
class(df)
View(df)  #ddply의 결과는 data frame형태로 나옴
#####################################################################
## plyr에서는 join()과 통계값을 구하는 함수 (2개)만 알아두시면 되요!!

## 실제로 data frame을 핸들링할때는 plyr을 개량한 dplyr을 이용
## dplyr은 C++로 구현되었기 때문에 속도가 빨라요
## dplyr은 코딩시 chaining을 사용할 수 있어요!

var1<- c(1,2,3,4,5)
var2<- var1 *2
var3<- var2 +5

# 중간변수를 만들지 않고 var1<- c(1,2,3,4,5)  *2  +5 이런식으로 변수 하나로 바로 과정을 수행하는 것 : chaining

install.packages("dplyr")
library(dplyr)

# fileServer : \\M1604INS
#제공된 excel을 data set으로 이용해 보아요
install.packages("xlsx") #엑셀 파일 불러올 수 있는 패키지
library(xlsx)
excel<-read.xlsx(file.choose(),
          sheetIndex = 1,
          encoding = "UTF-8")
excel
str(excel)
ls(excel)

# dplyr의 주요함수들
# 1. tbl_df(): 현재 console 크기에 맞추어서 보이는 만큼만 data frame을 추출하라는 함수
tbl_df(iris)

# 2. rename() :data frame의 column명의 쉽게 바꿀 수 있는 함수
#  rename(data frame,
#          바꿀컬럼명1=이전컬럼명1,
#          바꿀컬럼명2=이전컬럼명2,...)
# column명을 수정한 새로운 data frame이 리턴 **data frame 자체가 바뀌는 건 아니기 때문에 새로운 data frame에 다시 넣어줘야 함
# 제공된 excel을 읽어들여서 data frame을 생성한 후 column명을 보니 
# AMT17: 2017년도 이용금액
# Y17_CNT:  2017년도 이용횟수
df<-rename(excel,
           CNT17 = Y17_CNT,
           CNT16 = Y16_CNT)
df
#### data frame의 컬럼명을 바꿀 수 있어요!!

# 3. 하나의 data frame에서 하나 이상의 조건을 이용해서 데이터를 추출하려면 어떻게 해야 하나요?
# filter(data frame,
#        조건1,조건2,...)
excel 
filter(excel,
       SEX == "M",
       AREA == "서울")
#filter(excel, SEX == "M" & AREA == "서울") 이렇게 해도 괜찮음

## 지역이 서울 혹은 경기인 남성들 중 40살 이상의 사람들의 정보를 출력하세요
filter(excel,
       AREA == "서울" | AREA== "경기",
       SEX == "M",
       AGE >= "40")
## 지역이 서울 혹은 경기혹은 제주 인 남성들 중 40살 이상의 사람들의 정보를 출력하세요
filter(excel,
       AREA %in% c("서울","경기","제주"),  #%in% vector :vector 안에 있는 경우
       SEX == "M",
       AGE >= "40")

# 4. arrange(data frame,
#            정렬기준column1,desc(정렬기준column2),...)   **column1으로 정렬할 때 동률이 있으면 column2의 순서로 다시 정렬 
# 정렬의 기준은 오름차순 정렬 
# 만약 내림차순 정렬하려면 desc()

## 서울살고 남자에요.. 2017년도 처리금액이 400,000원 이상인 사람을 나이가 많은 순으로 출력하세요
df <-filter(excel, 
            AREA=="서울",
            SEX=="M",
            AMT17 >= 400000)
df2 <- arrange(df,
               desc(AGE))
#chaining이 가능하기 때문에 %>%를 이용해서 결과값을 추출할 수 있다
df <-filter(excel, 
            AREA=="서울",
            SEX=="M",
            AMT17 >= 400000) %>%
     arrange(desc(AGE))
df

# 5. select(data frame, column1, column2,...) 
# 추출하길 원하는 column을 지정해서 해당 column만 추출할 수 있어요

## 서울살고 남자에요.. 2017년도 처리금액이 400,000원 이상인 사람을 나이가 많은 순으로 ID와 나이, 그리고 2017년도 처리건수만 출력하세요
df <-filter(excel, 
            AREA=="서울",
            SEX=="M",
            AMT17 >= 400000) %>%
     arrange(desc(AGE))%>%
     select("ID","AGE","Y17_CNT") 
df

df1 <-filter(excel, 
            AREA=="서울",
            SEX=="M",
            AMT17 >= 400000) %>%
  arrange(desc(AGE))%>%
  select("ID":"AGE","Y17_CNT")#"ID":"AGE" 이렇게 하면 ID부터 AGE까지 ID,SEX,AGE의 값이 출력됨
df1

# 성별빼고 다 출력
df2 <-filter(excel, 
            AREA=="서울",
            SEX=="M",
            AMT17 >= 400000) %>%
  arrange(desc(AGE)) %>%
  select(-"SEX")  # -SEX이렇게 써도 됨
df3

# 6. 새로운 column을 생성할 수 있어요!
excel
#17년대 처리금액을 기준으로 500000인 사람을 VIP, 나머지는 NORMAL
excel$GRADE = ifelse(excel$AMT17 >= 500000, #없는 column명을 써주고 내용 주면 됨
                     "VIP", #ifelse TRUE면
                     "NORMAL") #ifelse FALSE면

# dplyr은 새로운 column을 생성하기 위해 함수를 제공
# mutate(data frame,
#        컬럼명1 = 수식1,
#        컬럼명2 = 수식2)
# 수식이 아니라 값으로 줘도 됨

# 경기사는 여자를 기준으로 17년도 처리금액을 이용하여 처리금액을 10%를 가산한 값으로 새로운 컬럼 AMT17_REAL 만들고 AMT17_REAL이 45만원 이상인 경우 VIP 칼럼 만들어서 TRUE, 그렇지 않으면 FALSE를 입력하세요

df<-filter(excel,
       AREA=="경기",
       SEX=="F")%>%
    mutate(AMT17_REAL = AMT17*1.1,
           VIP = ifelse(AMT17_REAL>=450000,"TRUE","FALSE"))
df

# 7. group_by() & summaries()
# 그루핑 해서 데이터를 추출하기
df <- filter(excel,
             AREA == "서울" & AGE > 30) %>%
      group_by(SEX)%>%  #성별로 grouping
      summarise(sum=sum(AMT17),cnt=n()) #통계를 구할건데 sum이라는 컬럼과 cnt라는 컬럼을 만들 거에요. sum에는 AMT17의 합과, cnt에는 결과값의 개수를 넣을 거에요
df
# A tibble: 2 x 3
#SEX       sum   cnt
#<fct>   <dbl> <int>
#1 F     1870000     2
#2 M      400000     1

# 8. plyr package의 join함수가 각 기능별로 독립적인 함수로 제공되요
# left_join()
# right_join()
# inner_join()
# full_join()

# 9. bind_rows(df1,df2) :행단위로 붙이는 것
# 주의할 점은 두 df의 column명이 같아야지 예쁘게dataframe이 결합됨
# 컬럼명이 같지 않으면 컬럼을 생성해서 결합이 되요!
df1<- data.frame(x=c("a","b","c"))
df1
df2<- data.frame(x=c("d","e","f"))
df2
bind_rows(df1,df2)

df1<- data.frame(x=c("a","b","c"))
df1
df2<- data.frame(y=c("d","e","f"))
df2
bind_rows(df1,df2) 

###################################################################
# 연습문제를 풀어보아요!

# MovieLens Data Set을 이용해서 처리해 보아요!
# 영화에 대한 평점 정보를 기록해 놓은 데이터 
# 평점은 1점 ~ 5점 (5점이 최대)
# 사람이 한두사람이 아니에요!!
# 영화도 굉장히 많아요!
# 구글에서 MovieLens 검색

# 데이터를 받았으면 데이터의 구조 확인
# 컬럼의 의미를 파악
require(xlsx)


# 1. 사용자가 평가한 모든 영화의 전체 평균 평점

# 2. 각 사용자별 평균 평점

# 3. 각 영화별 평균 평점

# 4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로 정렬해서 출력
#    (동률이 있는 경우 모두 출력)

# 5. comedy 영화 중 가장 평점이 낮은 영화의 
#    제목을 오름차순으로 출력
#    (동률이 있는 경우 모두 출력)

# 6. 2015년도에 평가된 모든 Romance영화의 평균 평점 출력


















