# 같은 데이터 타입을 저장하는 자료구조
# vector(1차원), matrix(2차원:가장 많이 사용함), Array(3차원 이상)

# 다른 데이터 타입을 저장하는 자료구조
# List(1차원)

# 범주형 자료구조 => factor
########################################################################

# factor
# 범주형 데이터를 저장하기 위한 자료구조
# 범주형 데이터는 
# 예를 들어 방의 크기가 "대", "중", "소" => level
# 일반적으로 vector를 이용해서 factor를 만즐어요

# 6명의 혈액형 데이터를 vector에 저장하고 factor(범주형 데이터) 로 변형해 보아요!

var1 = c("A","AB","O","A","B","B")
var1

factor_var1 = factor(var1) 
factor_var1
# [1] A  AB O  A  B  B 
# Levels: A AB B O

nlevels(factor_var1) #level의 갯수가 몇개 있니? (4)
levels(factor_var1) #어떤 level들이 factor안에 포함되어 있니? ( "A"  "AB" "B"  "O" )
is.factor(factor_var1) #이거 factor 맞니? (TRUE)

###########################################################################
#factor는 빈도 구할때 많이 사용함. 
#남성과 여성의 성별데이터로 factor를 생성하고 빈도수를 구해보아요!

var1 = c("MAN","WOMAN","MAN","MAN","MAN","WOMAN")
var1

factor_gender = factor(var1)
factor_gender

table(factor_gender) #빈도수를 찾는 방법
# MAN WOMAN 
#   4     2 

plot(factor_gender) #빈도 그래프를 그리는 함수 

#########################################################################

# List
# 1차원 선형구조, 다른 데이터 타입이 들어올 수 있어요.
# 중첩 자료구조로 이용

# 지금까지 했던 여러 자료구조들을 생성해서 List안에 저장해 보아요!
# 다른 자료구조(vector, array, matrix)들을 List안에 저장할 수 있다

var_scalar = 100 #scalar : vector 중에서 값을 하나만 저장할 수 있는 형태
var_scalar

var_vector = c(10,20,30) #vector
var_vector

var_matrix = matrix(c(1:12), ncol=3, nrow=4, byrow=TRUE)
var_matrix

var_array = array(c(1:12),dim=c(2,2,3)) #dim의 vector개수 = 차원
var_array

# 데이터 프레임 : 다른 데이터 타입, matrix와 비슷. but, matrix가 결과처리 속도가 더 빠름 
# 열별로 다른 데이터 타입을 지정할 수 있다
var_df = data.frame(id=1:4, name=c("홍길동","김길동","최길동","이길동"), age=c(30,40,20,10))
var_df
#    id   name age
# 1  1 홍길동  30
# 2  2 김길동  40
# 3  3 최길동  20
# 4  4 이길동  10

myList = list(var_scalar, var_vector, var_matrix, var_df)
myList
# [[1]]
# [1] 100

# [[2]]
# [1] 10 20 30

# [[3]]
#      [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6
# [3,]    7    8    9
# [4,]   10   11   12

# [[4]]
#    id   name age
# 1  1 홍길동  30
# 2  2 김길동  40
# 3  3 최길동  20
# 4  4 이길동  10

myVector = c(10,20,30)
myVector[2] #20 
myVector[2:3] #20 30

#key와 value로 저장되는 자료구조이고
#데이터를 출력할 때 key값도 같이 출력
myList [1] # 첫번째 공간을 access하는 것
# [[1]]      :key 값.
# [1] 100
myList[[1]] # key값을 이용해서 데이터를 출력할 수 있다
# [1] 100


myList= list(name=c("홍길동","김길동"), age=c(20,30), address=c("서울","부산")) #각각의 공간에 key값을 부여 =>$key로 출력된다
myList
# $name
# [1] "홍길동" "김길동"

# $age
# [1] 20 30

# $address
# [1] "서울" "부산"

myList[1]                #첫번째 방에 있는 key와 value가 출력됨
# $name
# [1] "홍길동" "김길동"
myList$name              #key로 value를 access =>이 형태를 일반적으로 사용
# [1] "홍길동" "김길동"
myList$name[2]           #name 키의 2번째 있는거 무엇이냐?
# [1] "김길동"
myList[[1]]              #key값을 부여한 후에도 이렇게 access가능
# [1] "홍길동" "김길동"
myList[["name"]]         #키가 name인거 가져와
# [1] "홍길동" "김길동"


##########################################################################

# data frame
# matrix와 같은 2차원 형태의 자료구조
# 다른 데이터 타입을 사용할 수 있어요!
# column명을 이용할 수 있어요
# Database의 Table과 유사해요!

# 간단한 예를 이용해 보아요!
  
# vector를 이용해서 data frame을 만들어 보아요!

no=c(1,2,3)
name=c("홍길동","김길동","최길동")
age=c(10,20,30)

df = data.frame(s_no=no,s_name=name,s_age=age) #s_ : col명,뒤에꺼가 vector
df
#   s_no s_name s_age
# 1    1 홍길동    10
# 2    2 김길동    20
# 3    3 최길동    30

df[1] #첫번째열을 지칭
#    s_no
# 1    1
# 2    2
# 3    3
df$s_name #df 안의 s_name이라는 col을 알고 싶어
# [1] 홍길동 김길동 최길동
# Levels: 김길동 최길동 홍길동    #범주형태로 access

#$는 List에서는 key, df에서는 column

myMatrix = matrix(c(1:12),ncol=3,nrow=4,byrow=T)
myMatrix

df_mat = data.frame(myMatrix)
df_mat
#   X1 X2 X3
# 1  1  2  3
# 2  4  5  6
# 3  7  8  9
# 4 10 11 12

# data frame의 함수
str(df) #해당 df에 대한 전반적인 구조를 보여줌
# 'data.frame':	3 obs. of  3 variables:   *3개의행,3개의 열
# $ s_no  : num  1 2 3                    *column이름과 type과 데이터 출력
# $ s_name: Factor w/ 3 levels "김길동","최길동",..: 3 1 2
# $ s_age : num  10 20 30

summary(df) #df의 간단한 요약통계를 볼 수 있다
#     s_no        s_name      s_age   
# Min.   :1.0   김길동:1   Min.   :10  
# 1st Qu.:1.5   최길동:1   1st Qu.:15  
# Median :2.0   홍길동:1   Median :20  
# Mean   :2.0              Mean   :20  
# 3rd Qu.:2.5              3rd Qu.:25  
# Max.   :3.0              Max.   :30  

apply() #df에도 적용할 수 있어요!

df = data.frame(x=c(1:5),y=seq(2,10,2),z=c("a","b","c","d","e"))
df  #데이터 구조의 형태가 맞아야지만 가능,안 맞으면 error
df = data.frame(x=c(1:5),y=seq(2,10,2),z=c("a","b","c","d","e"),stringsAsFactors=F) #string을 factor로 가져오지 않을 것이야 => character로 
str(df)

#연습문제
#주어진 data frame의 1,2번째 column에 대해서 각각 합계를 구하세요!
#apply()함수를 이용해 보아요!

apply(X=df[,c(1:2)],MARGIN=2,FUN=sum) #행자리는 비워두고 열자리 원하는부분 
apply(X=df[,c(-3)],MARGIN=2,FUN=sum)
# x  y 
# 15 30 
apply(X=df[1:2],MARGIN=2,FUN=sum)
apply(X=df[-3],MARGIN=2,FUN=sum)
apply(X=df[c("x","y")],MARGIN=2,FUN=sum)

# subset()
# data frame에서 조건에 맞는 행을 추출해서 독립적인 data frame을 생성

df = data.frame(x=c(1:5),y=seq(2,10,2),z=c("a","b","c","d","e"))
df

subset(df,x > 3) 

#x가 3보다 작고 y가 4이상인 데이터를 추출해보세요
df_sub = subset(df,x<3&y>=4) #&나|을 사용해서 조건을 정해줄 수 있다

######################################################################

# 6개의 자료구조에 대해서 알아보았어요!
# 배운내용을 복습하기 위해서 간단한 연습문제를 풀어보아요!

# 1. 4,6,5,7,10,9,4 데이터를 이용해서 숫자형 vector를 생성하세요!
x = c(4,6,5,7,10,9,4); x

# 2. 아래의 두 벡터의 연산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,4)

x1+x2  #6 8 10 11 (recycling rule)

# 3. data frame을 이용하여 다음의 결과를 도출하세요
Age = c(22,25,18,20)
Name= c("James","Mathew","Olivia","Stella")
Gender = c("M","M","F","F")
## 출력형태

##   Age  Name    Gender
## 1  22  James      M
## 2  25  Mathew     M

df=data.frame(Age=Age,Name=Name,Gender=Gender)
df[1:2,]
subset(df, Gender == "M")
subset(df, Gender != "F")
subset(df, Age >=22)

# 4. 아래의 구문을 실행한 결과는?
x = c(1,2,3,4,5)
(x*x)[!is.na(x) & x > 2]

#(1 4 9 16 25)[(T T T T T)& (F F T T T) ]
#             [(F F T T T)] # Fancy indexing : 그대로 mapping 후 T만 남김
# 9 16 25

# 5. 다음의 계산 결과는?
x = c(2,4,6,8)
y = c(T,T,F,T)
sum(x[y]) #Fancy indexing : T만 남기고 다 버려라

# 6. 제공된 vector에서 결측치(NA)의 개수를 구하는 코드를 작성하세요!
var1 = c(34,55,89,45,NA,22,12,NA,99,NA,100)
sum(is.na(var1)) #TRUE인 1만 남으니까 sum으로 구하면 된다
#결측치를 제외한 평균을 구하세요!
mean(var1[!is.na(var1)])

# 7. 두개의 벡터를 결합하려 해요!
x1 = c(1,2,3)
x2 = c(4,5,6)
# 1 2 3 4 5 6
c(x1,x2) 
# vector를 결합해서 matrix를 만들어보아요
rbind(x1,x2) #행단위 결합
cbind(x1,x2) #열단위 결합

# 8. 다음 코드의 실행 결과는?
x = c("Blue",10,TRUE,20) #vector는 우선순위에 따라 상위type로 통일
is.character(X) #TRUE
















