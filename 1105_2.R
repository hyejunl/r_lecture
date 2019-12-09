
# 데이터 정제

# 우리가 얻는 raw data는 항상 오류를 포함하고 있어요!!
# 분석하기 전에 데이터 오류를 수정해야 해요!

# 1. 결측치(NA) 처리 
# 결측치는 누락된 값을 지칭. 비어있는 값을 지칭
# 결측치가 있으면 함수적용이 잘못될 수 있어요!
# 분석자체가 잘못될 수 있어요!

# 결측치를 찾아야 해요!

# 간단하게 결측치가 있는 data set을 하나 만들어요

df <- data.frame(id=c(1,2,NA,4,5,NA,7), # NA는 무조건 대문자로 써야함
                 score=c(20,30,90,NA,60,NA,99))
df
sum(is.na(df)) # NA의 갯수 확인 => NA가 있는지 확인 

table(is.na(df$id)) #빈도 구하는 함수 table을 이용해서 결측치 확인
#FALSE  TRUE 
#    5     2 

# 결측치를 제거하려 해요!
# => data frame이기 때문에 결측치가 들어가 있는 행을 삭제

df%>%
  filter(id!="NA",
         score!="NA")

df%>%
  filter(!is.na(id),
         !is.na(score))

na.omit(df) # na.omit() : df 안의 결측치가 들어간 행 다 날려

### 행을 지우는 행위는 그다지 좋지 않은 행위
### 행을 지우면 결측치 뿐만 아니라 정상데이터도 같이 삭제되기 때문에 분석시 문제가 될 수 있어요
df
mean(df$score) # NA와의 연산결과는 무조건 NA

mean(df$score, na.rm=T) # NA를 제외하고 연산 

## 결측치가 포함된 행을 삭제하기에는 부담이 되요!
## score 안에 있는 결측치(NA)값을 다른 값으로 대체해서 score의 평균을 구해보아요!
## score열에 대해 NA를 NA를 제외한 평균을 구해서 그 값으로 NA를 대체

df

df$score<-replace(df$score,is.na(df$score),mean(df$score,na.rm = T))
df

df$score[is.na(df$score)]<-mean(df$score,na.rm=T)
df

df$score <-ifelse(is.na(df$score),
                  mean(df$score,na.rm=T),
                  df$score)
df
######################################################################

# 결측치 ( NA )

# 이상치 
# 존재할 수 없는 값이 포함된 경우

# 극단치 : 정상적인 범주에서 너무 벗어난 값이 들어온 경우
# ( 정상적인 범주는 어떻게 정하나요? )

df <- data.frame(id=c(1,2,NA,4,5,NA,7), 
                 score=c(20,30,90,NA,60,NA,99),
                 gender=c("M","F","M","F","M","F","^^"),
                 stringsAsFactors=F) #data type을 factor로 잡지 않을게
df

# 이상치가 존재하면 결측치로 바꿔줘요.
df$gender<- ifelse(df$gender%in% c("F","M"),
                   df$gender,
                   "NA")
df
df$gender<- ifelse(df$gender=="F"|df$gender=="M",
                   df$gender,
                   "NA")

df$gender[!df$gender%in% c("F","M")]<-"NA"
df

######################################################################

### 극단치 : 이상치 중에 값이 극단적으로 크거나 작은 값을 의미

# 기준을 정해야 해요! => 기준이 있어요!

# 극단치를 분류하는 기준은 IQR을 이용해요
# (interqualtile range) 
# 4분위부터 알아보도록 해요!

# 극단치를 알아보기 위한 sample 작성 
data <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,22.1)

# 기본통계값을 이용해서 사분위 값을 알아보아요
summary(data)
lower_data = c(1,2,3,4,5,6,7,8)
upper_data = c(8,9,10,11,12,13,14,22.1)

# IQR : 데이터 중간 위쪽의 mid point -
#       데이터 중간 아래쪽의  mid point
iqr_value<-median(upper_data) - median(lower_data) #[1] 7

# 극단치를 결정하는 기준값 : IQR * 1.5
deter_value <- iqr_value * 1.5 # 10.5

# 3사분위값 + 기준값 
# 11.5 + 10.5 = 22
# 위쪽으로 22 초과하면 극단치야
# 1사분위값 - 기준값
# 아래쪽으로 이것보다 작으면 극단치가 나오게 됨

# 계산을 통해서 극단치를 판단하는 방법


# 그래프를 이용하면 극단치를 눈으로 확인
boxplot(data) #그래프에서 동그라미로 표현되는 것은 극단치이기 때문에 제거해 준다 
boxplot(data)$stats # 이렇게하면 매트릭스 형식으로 뽑아낼 수 있다
#maximum인 14 넘어가는거는 다 NA로 바꾼 후에 처리


#moon9342.github.io






