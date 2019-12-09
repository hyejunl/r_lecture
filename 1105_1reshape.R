
# reshape 2 package
# 데이터의 형태를 바꿀 수 있어요!
# 가로로 되어 있는 데이터를 세로로 바꿀 수 있어요!
# 컬럼으로 저장되어 있는 데이터를 row형태로 
# row형태의 데이터를 column형태로 전환

# 이해를 돕기 위해 2개의 sample file을 이용해 보아요

# melt_mpg.csv
# sample_mpg.csv

sample_mpg <- read.csv(file="C:/lecture2/data/sample_mpg.csv",
                       sep=",", #구분자 지정 (csv는 딱히 안써도 됨)
                       header=T, #헤더가 있다 (default는 맨 윗줄을 header로)
                       fileEncoding = "UTF-8") #한글도 가능하도록 인코딩
sample_mpg

melt_sample_mpg <- read.csv(file="C:/lecture2/data/melt_mpg.csv",
                       sep=",", 
                       header=T, 
                       fileEncoding = "UTF-8") 
View(melt_sample_mpg)

# 두개의 data frame에 대해서 평균 도시 연비
library(ggplot2)
library(stringr)
library(dplyr)

sample_mpg
mean(sample_mpg$cty) #[1] 18.25

melt_sample_mpg
melt_sample_mpg%>%
  filter(variable=="cty")%>%
  summarise(avg_rate=mean(value))

# 두개의 data frame에 대해서 평균 연비를 구해서 표시 (평균 연비 = 도시 연비와 고속도로 연비의 평균으로 계산)
sample_mpg
sample_mpg%>%
  mutate(avg_rate = (cty+hwy)/2)

melt_sample_mpg # 너무 힘들어요!

### reshape2 package는 수집한 데이터를 분석하기 편한 형태로 가공할 때 사용하는 대표적인 package

### 2개의 함수만 잘 알아두면 되요!!
### 1. melt()

# column을 row형태로 바꾸어서 가로로 긴 데이터를 세로로 길게 전환하는 함수
# melt()의 기본동작은 numeric을 포함하고 있는 모든 column을 row로 변환해요!

# 간단한 예를 통해서 melt()의 동작방식을 알아보아요!
install.packages("reshape2")
library(reshape2)

# 기본적으로  R이 내장하고 있는 data set
help(airquality) # document
airquality
ls(airquality) # column명 
head(airquality)
str(airquality)

df <- airquality # 원본은 건들지 말아요!! 

df           # 153행, 6열
melt(df)     
nrow(melt(df)) # 153 * 6 = 918행

nrow(melt(df,na.rm=T)) #na는 remove해라  # 874행. 결측지를 제외

melt(df, id.vars = "Month") #id.vars로 녹이지 말아야 행을 잡는다
# 153 * 5 = 765행
melt(df, id.vars = c( "Month","Day")) #id.vars로 2개 주려면 vector형태로 주면 된다. 
melt_df<- melt(df, id.vars = c( "Month","Day"),
     measure.vars ="Ozone" ,  #measure.vars로 녹일 column만 지정해준다
     variable.name = "Item", # variable column이름 정해주기
     value.name = "Item_value") # value column이름 정해주기
# Ozone만 녹이고 Month와 Day만 고정시켜서 추출해라
# 변수 열의 이름은 Item, 변수 값의 열의 이름을 Item_value로 한다
melt_df

# 2. dcast() : data frame에 대한 cast 작업
# **acast()는 벡터나 array, dcast()는 data frame.
# row로 되어 있는 데이터를 column 형태로 전환

dcast(melt_df,
      formula = Month + Day ~...) #어떤 형태로 변환시킬건지 명시
# Month + Day 이게 복귀 아이디가 되는 거고
# ~... 나머지 모두를 복귀 시킬거다
# dcast결과로 Ozone이 column으로 올라오게 된다.
dcast(melt_df,
      formula = Month ~...)

dcast(melt_df,
      formula = Month ~Item,
      fun=mean,
      na.rm=T)
#Month    Ozone
#1     5 23.61538
#2     6 29.44444
#3     7 59.11538
#4     8 59.96154
#5     9 31.44828

## 처음에 생성한 csv파일의 내용을 원상복구시켜보아요!!
melt_sample_mpg

dcast(melt_sample_mpg,
      formula = manufacturer+model+class+trans+year ~ variable,
      value.var = "value") #variable값은 어디있는지 알려주는 것
# Aggregation function missing: defaulting to length 오류!!
# 원래 있던 data가 unique하지 않아서 제대로 원상복구 시킬 수 없다
# melt_sample_mpg 이놈을 보면, 1번놈과 3번놈이 value값 빼고 전부 똑같음=>그래서 구분할 수가 없어서 오류가 뜨는 것

## 제공된 파일을 이용한 melt 형식의 data frame은 원상 복구될 수 없어요

## melt()된 데이터를 생성해 보아요!
## mpg를 가지고 melt data set를 생성해 보아요!
df<-as.data.frame(mpg)
head(df)
audi_df<-df%>%
         filter(manufacturer == "audi",
                model == "a4")
audi_df

melt_audi_df <- melt(audi_df,
                     id.vars = c("manufacturer",
                                 "model",
                                 "year",
                                 "cyl",
                                 "trans"),
                     measure.vars = c("displ",
                                      "cty",
                                      "hwy"))

melt_audi_df #똑같은 row가 존재하지 않는 데이터여야만 dcast로 복구 가능

dcast(melt_audi_df,
      formula=manufacturer+model+year+cyl+trans ~ variable,
      value.var = "value")
# formula = 남길 column들은 +로 연결 melt를 풀 애는 ~뒤에 쓰고,
# value.var = variable의 값이 있는 column이 어디인지 명시

#########################################################################











