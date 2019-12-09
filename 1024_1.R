var1 = c("홍길동") #값이 하나짜리 vector : scalar
var2 = c(10,20,30)

#변수 삭제하는 법 : environment창 빗자루, rm(list=ls())

rm(list=ls()) #ls() :환경창에 있는 객체들
cat("\014") #console clear

############################################################################

getwd()
setwd("C:/lecture2/data")
student_midterm = read.table(file="midterm.txt",sep=",",fileEncoding="UTF-8")
student_midterm

# 파일로부터 데이터를 읽어들일때 일반 txt 형식은 많이 사용되지 않아요!

# 컴퓨터 간에 데이터를 주고 받으려고 해요
# process 간에 데이터 통신을 하기 위해서 특정 형식을 이용해 데이터를 주고 받아요! (3가지 형식)

# 1. csv ( comma seperated value )
# comma기호를 이용해서 데이터를 구분.
# 해당 문자열을 전달해서 데이터 통신
# 예) "홍길동,20,서울,김길동,30,부산,최길동,50,인천,..."
# csv 방식 장점 : 간단해요. 부가적인 데이터가 적어요!
# 상대적으로 크기가 작아요!=> 많은 양의 데이터를 처리할 수 있어요!
# csv 방식 단점 : 구조적 데이터를 표현하기에 적합하지 않아요! (간단하지 않은 형태의 중첩 데이터들을 다루기가 어렵다.) => parsing(데이터를 프로그램적으로 표현하는 것) 작업이 복잡해요.
# 유지보수의 문제가 발생해요!

# 2. XML 방식 (csv의 단점을 해결하기 위해 고안된 방식)
# tag를 이용해서 데이터를 표현하는 방식 
# 예) <name>홍길동</name><age>20</age><address>서울</adress>...
# <phone>
#       <mobile>010-111-22210</mobile>
#       <home>02-342-2233</home>
# </phone>
# 장점 : 구조적데이터를 표현하기에 적합, 사용하기 편리, 태그 이름을 활용해서 데이터의 의미를 표현할 수 있어요
# 단점 : 부가적인 데이터가 너무 커요! 

# 3. JSON ( JavaScript Object Notation )
# 예) { name: "홍길동", age : 20, address : 서울,... }
# 구조적 표현이 가능하면서 XML보다 크기가 작아요!!

##########################################################################

#read.table() : sep가 있어야 해요!
#read.csv() : sep가 ","이기 때문에 생략
#             header=T가 기본
getwd()

df = read.csv(file.choose(),fileEncoding="UTF-8")
df

#Excel 파일을 불러올 수 있어요!
#확장 package를 이용해야 해요!
#R을 설치하면..=> base system이 설치된다고 표현해요!
#base package, recommended package
#other package

#xlsx package를 설치하고 로딩해요!
.libPaths("c:/lecture2/lib") #package저장공간 변경
install.packages("xlsx")
library(xlsx)

Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_231")
# Sys.setenv(): 환경변수 설정 함수
# \ 두번 해줘야 함

student_midterm <- read.xlsx(file.choose(),
                            sheetIndex = 1,   #첫번째 시트에서 가져온다 
                            encoding = "UTF-8")
student_midterm;
summary(student_midterm)
class(summary(student_midterm)) #table

#######################################################################

# 처리된 결과를 file에 write 해요!
# write.table() : data frame을 file에 저장
# cat() : 분석결과(vector)를 file에 저장 
# capture.output()      : 분석결과(List,table)을 file에 저장

cat("처리된 결과는 :","\n","\n", #"\n"은 한줄 띄우라는 얘기
    file="C:/lecture2/data/report.txt", #파일이 없으면 자동으로 만듦
    append=T) #append는 파일을 새로 만드는게 아니라 있던 파일에 덧붙임

#기본형
write.table(student_midterm,
            file="C:/lecture2/data/report.txt",
            append=T)

#행번호삭제, ""삭제
write.table(student_midterm,
            file="C:/lecture2/data/report.txt",
            row.names = F, #행번호 삭제!
            quote=F,        #""삭제
            append=T)

capture.output(summary(student_midterm),
               file="C:/lecture2/data/report.txt",
               append=T)

# read.xlsx 있으니 write.xlsx보기
# write.xlsx()

df = data.frame(x=c(1:5),y=seq(1,10,2),z=c("a","b","c","d","e"),stringsAsFactors=F)
df

write.xlsx(df,file = "C:/lecture2/data/report.xlsx" ) #excel형태로 만들어짐



