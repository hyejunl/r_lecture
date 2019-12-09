# 문자열 처리에 대해서 알아보아요!!
# 빅데이터 : 많은 양의 데이터 
#          : 3V
#          : 1. Volume : 일반적인 처리로는 제한된 시간내에 처리할 수 없을 정도로 많은 양의 데이터
#          : 2. Velocity : 지속적으로 빠른 속도로 생성되는 데이터
#          : 3. Variety : 다양한 종류의 데이터  

# 일반적으로 빅데이터 처리는 문자열 처리를 동반하는 경우가 많아요!
# 문자열 처리는 stringr package를 이용하면 쉽고 편하게 할 수 있어요!
install.packages("stringr")
require(stringr)

var1 = "Honggd1234Leess9032YOU25최길동2009"

# 1. 문자열의 길이를 구해보아요!
str_length(var1) #문자열 길이 구하는 함수
# R은 한글 1글자도 1개

# 2. 찾는 문자열의 시작과 끝을 알려줘요!
str_locate(var1,"9032")
#      start end
# [1,]    16  19
class(str_locate(var1,"9032")) #matrix <= class()는 자료구조를 알아내는 것 mode()는 데이터 타입을 알아내는 것

# 3. 부분문자열을 구해보아요!
str_sub(var1,3,8) #"nggd12" 시작과 끝 둘 다 inclusive

# 4. 대소문자 변경
str_to_lower(var1) #소문자 
str_to_upper(var1) #대문자

# 5. 문자열 교체
var1 = "Honggd1234HongLeess9032YOU25최길동2009"
str_replace(var1,"Hong","KIM") #처음 찾은 하나만 바꿈
# "KIMgd1234HongLeess9032YOU25최길동2009" 
str_replace_all(var1,"Hong","KIM") #몽땅 찾아서 바꿈

# 6. 문자열 결합
var2 = "홍"
var3 = "길동"

str_c(var2,var3) # "홍길동"

# 7. 문자열 분할
var1 = "Honggd1234,Leess9032,YOU25,최길동2009"
str_split(var1,",") #,를 기준으로 분할할거야, list형태로 분할
class(str_split(var1,",")) #list

# 8. 문자열 결합 (vector안의 데이터들을 하나의 문자열로 결함할때는 paste)
var1= c("홍길동","김길동","최길동")
str_c(var1) #"홍길동" "김길동" "최길동" :하나의 문자열로 결합되지 않음
paste(var1,collapse ="-") #-를 기준으로 문자열을 하나로 붙일거야.("홍길동-김길동-최길동")
paste(var1,collapse ="") #"홍길동김길동최길동"

#######################################################################

# 문자열 처리를 쉽고 편하기 하기 위해서는 정규표현식(regular expression)

var1 = "Honggd1234,Leess9032,YOU25,최길동2009"

#조건에 부합하는 문자열을 추출
str_extract_all(var1,"[a-z]{4}") #"ongg" "eess"

#[a-z]:a부터 z까지의 소문자 
#[a-z]{4} : a부터 z까지 소문자로 연달아서 4개 나오는 것 
str_extract_all(var1,"[A-Z]{2}") #"YO"
str_extract_all(var1,"[a-z]{2,}") #소문자로 연달아 2개 이상나오는 것 ("onggd" "eess")
str_extract_all(var1,"[a-z]{2,3}") #소문자로 연달아 2~3개 나오는 것 ("ong" "gd"  "ees") 3개 먼저 끊고 그 다음 2개

var1 = "Honggd1234,Leess9032,YOU25,최길동2034"
str_extract_all(var1,"34") #"34" "34"

# 한글만 추출해보아요!
str_extract_all(var1,"[가-힣]") #[가-힣] 한글을 지칭함 ("최" "길" "동")
str_extract_all(var1,"[가-힣]{2,}") ("최길동")
# 숫자문자를 추출해 보아요!
var1="Honggd1234,Leess9032,YOU25,최길동2034"
str_extract_all(var1,"[0-9]{2,}") #"1234" "9032" "25"   "2034"

# 한글을 제외한 나머지 문자들 추출
var1="Honggd1234,Leess9032,YOU25,최길동2034"
str_extract_all(var1,"[^가-힣]{5}") #한글이 아닌 연속된 5개 찾아 ("Hongg" "d1234" ",Lees" "s9032" ",YOU2")

# 주민등록번호를 검사해 보아요!
myId ="801112-1210419"

#앞에는 숫자 연달아 6, 뒤에 -기호가 나와야 해, 뒤에숫자는 1-4중에 하나여야 해, 
str_extract_all(myId,"[0-9]{6}-[1234][0-9]{6}")
str_extract_all(myId,"[0-9]{6}-[1-4][0-9]{6}") #추출되면 맞는 것, [[1]]character(0) 이렇게 나오면 틀린 것

# 데이터 입출력
# 키보드로부터 데이터를 받을 수 있어요!
# scan() 함수를 이용해서 숫자데이터를 받을 수 있어요!!
myNum <- scan() #console창에서 입력후에 enter하고 출력
myNum #[1] 1 2 3 4


#scan()을 이용해서 문자열도 입력받을 수 있어요!!
var1 = scan(what=character()) #문자열도 입력 받을 거야 설정
var1 #[1] "이것은"   "소리없는"

# 키보드로부터 데이터를 받기 위해서 
# edit() 함수를 이용할 수 있어요! (df를 띄워서 df를 수정하는 방식)

var1 = data.frame() #빈칸으로 df 만들기 => 비어있는 df

df = edit(var1) #창이 뜨면서 직접 칸을 채워서 df를 만들 수 있다
df

#################################################################

# 파일로부터 데이터를 읽어보아요!

# text 파일에 ","로 구분된 데이터들을 읽어들여 보아요!!

# read.table()을 사용
getwd()
#c:/R_Lecture 와 /data
setwd(str_c(getwd(),"/data"))

student_midterm = read.table(file="midterm.txt", sep=",",fileEncoding = "UTF-8")
# sep 구분자 => ,로 구분되어 있다 , fileEncoding으로 한글도 가능하게
student_midterm = read.table(file.choose(), sep=",",fileEncoding = "UTF-8") #file.choose()를 이용해서 파일을 찾을 수도 있다
student_midterm

student_midterm = read.table(file.choose(), sep=",",fileEncoding = "UTF-8",header = T) #header가 있을 경우에는 header = T를 해야 한다.

class(student_midterm) #"data.frame"

help(read.table)













