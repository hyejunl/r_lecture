#R은 통계계산을 위한 프로그래밍 언어이자 소프트웨어
#통계학과 교수인 로스 이하카와 로버트 젠틀맨 두사람이 일반 사람들도 쉽게 통계를 할 수 있도록 Bell 연구소에서 사용하던 s라는 통게프로그램을 모태로 1993년에 만들었어요!
# R의 장점 : 무료 => 많은 사람들이 사용 => 오픈소스 생태계가 잘 유지되요!
# R & Python : R은 분석에 초점, Python은 프로그램에 접목하는데 초점
# R 다운로드, RStudio 
# R 프로그램의 기본 
# 주석 : #
# statment의 종료 : ; (생략가능)
# R은 대소문자를 구별 : case-sensitive
# 변수이름을 지을 때 : camelcase notation 
#                      my_report 

#변수 assignment
myVar = 100
myVar <- 100
100 -> myVar

#변수 출력
myVar
print(myVar)
cat("변수의 값은 :",myVar)

var1 = seq(1,100,3) #등차수열 (1부터 100까지 3씩 증가)
var1

#######################################################################

# 연산자에 대해서 알아보아요!
# operator
var1 = 100 # 실수 끝에 L을 붙여야만 정수 
var2 = 3

result <- var1 / var2 # 숫자 7개를 출력하도록 default 값이 설정되어있음
result
options(digits = 5) # 숫자를 5개 출력하도록 지정 설정하는 방법
sprintf("%.9f", var1/var2) #소수점 9자리까지 실수형태로 출력하겠어 (10번째자리에서 반올림해서 출력)

var1 %/% var2 #33 (몫)
var1 %% var2  #1 (나머지)

#비교연산자
var1 == var2 #FALSE (F) (같니?)
var1 != var2 #TRUE (T) (같지 않니?)

# & , | (and연산과 or연산) (vector 연산시 같은 자리에 있는 것들끼리 비교)
# && , || (vector에 대한 연산 수행시 첫번째 요소만을 비교)

######################################################################

# Data Type
# 기본 데이터 타입 4개
# numeric, character("",''), logical, complex
# NULL(변수에 값이 없다), NA(결측치), NaN(숫자긴한데 연산을 할 수 없는 숫자), Inf

# R이 제공하는 기본함수중에 데이터 타입을 알아보는 함수 => mode()
var1 = "이것은 소리없는 아우성!!"
mode(var1)
# is계열의 함수 => is.character()
is.character(var1)
is.null()
is.na()
# R의 데이터타입은 우선순위가 존재해요!
# character > complex > numeric > logical

# R은 하나의 데이터 타입을 다른 데이터 타입으로 바꿀 수 있어요!! (type casting)
# as계열의 함수를 제공해줘요!!
var1 = "3.141592"
as.double(var1) 

var2 = TRUE
as.numeric(var2) #TRUE는 1, FALSE는 0

var3 = 100
as.logical(var3) #0은 FALSE, 0이외의 숫자는 다 TRUE



























