# matrix : 동일한 data type을 가지는 2차원 형태의 자료구조
# matrix의 생성 
var1 = matrix(c(1:5)) # matrix의 생성 기준은 열!!(열은 하나로 고정) => 5행 1열
                      # 5행 1열짜리 matrix가 생성
var1

var1 = matrix(c(1:10), nrow=2) #nrow는 행의 개수 (데이터는 10개인데 행이 2개 =>열이 5개가 됨) **ncol : 열의 개수 지정할 수 있다
var1 # 값은 열 기준으로 채워짐 (2행 5열짜리 matrix) 
     #1 3 5 7 9
     #2 4 6 8 10

var1 = matrix(c(1:10), nrow=3) # 행이3개 열은 4개 만들어지고 빈자리는 recycling으로 채워짐
var1

var1 = matrix(c(1:10), nrow=2, byrow = TRUE) #2행 5열, 데이터를 행 기준으로 채워라 
var1 #1 2 3 4 5
     #6 7 8 9 10

# vector를 연결해서 matrix를 만들 수 있어요!
# vector를 가로방향, 세로방향으로 붙여서 2차원 형태로 만들 수 있어요!
var1 = c(1,2,3,4)
var2 = c(5,6,7,8)

mat1 = rbind(var1,var2) #행 단위로 붙인다. row bind
mat1
#      [,1] [,2] [,3] [,4]
#var1    1    2    3    4 ([]도 사용할 수 있고, vector이름으로도 사용가능)
#var2    5    6    7    8

mat2 = cbind(var1,var2) #열 단위로 붙인다. col bind
mat2
#     var1 var2
#[1,]    1    5
#[2,]    2    6
#[3,]    3    7
#[4,]    4    8

var1 = matrix(c(1:21), nrow=3, ncol=7) #3행 7열짜리 matrix
var1

var1[1,4] #1행 4열의 데이터 가져와라

var1[2,] #2행의 모든 열을 가져와라
var1[,3] #3열의 모든 행을 가져와라

#11 12 14 15의 값을 가져오려면?
var1[c(2,3),c(4,5)]
var1[2:3,4:5]

length(var1) #matrix의 원소 갯수 
nrow(var1) #row(행)갯수 몇개야? 
ncol(var1) #col(열)갯수 몇개야?

var1 = c(20,60,90,100,40,76,99)
mean(var1) #평균

# matrix에 적용할 수 있는 함수가 있어요!
# apply() 함수를 이용해서 matrix에 특정 함수를 적용
# apply() 함수는 속성이 3개 들어가요
# X=>적용할  matrix
# MARGIN => 1이면 행 기준, 2이면 열 기준
# FUN => 적용할 함수명 
var1 = matrix(c(1:21), nrow=3, ncol=7)
var1
apply(X=var1, MARGIN = 1, FUN = mean) # 행단위로 적용시키겠어 (10 11 12)
apply(X=var1, MARGIN = 1, FUN = max) # 19 20 21
apply(X=var1, MARGIN = 2, FUN = mean) #열단위로 적용시키겠어(2 5 8 11 14 17 20)
apply(X=var1, MARGIN = 2, FUN = max) #3 6 9 12 15 18 21
# 이미 우리에게 제공되는 함수만 이용할 수 있나요?
# 적용할 함수를 우리가 직접 만들어서 사용할 수 있어요! 

## matrix의 연산
# matrix의 요소단위의 곱연산
# 전치행렬을 구해보아요!
# 행렬곱(matrix product)
# 역행렬(matrix inversion) => 가우스 소거법 이용

var1 = matrix(c(1:6), ncol=3) #2행 3열
var1
var2 = matrix(c(1,-1,2,-2,1,-1), ncol=3)
var2

# elementwise product(요소단위 곱연산) 
var1 * var2 #같은 위치의 것끼리 곱하기 연산
#matrix product (행렬곱)
var1 %*% var2 #2*3, 2*3 행렬곱 불가능 error

var3 = matrix(c(1,-1,2,-2,1,-1), ncol=2)
var3
var1 %*% var3 
#     [,1] [,2]
#[1,]    8   -4
#[2,]   10   -6

#전치 행렬( transpose ) 행과 열을 뒤바꾸는 것
var1
t(var1) #행과 열이 뒤바뀜

#역행렬 : matrix A가 n*n일 때 다음의 조건을 만족하는 행렬 B가 존재하면 행렬 B를 A의 역행렬이라고 해요!!
# AB = BA = I(단위행렬 E)
solve(var1%*%var3) #반드시 square여야한다. 아니면 error

#######################################################################

# Array : 3차원 이상. 같은 데이터 타입으로 구성
var1 = array(c(1:24), dim=c(3,2,4)) #dim은 차원 dim=c(행,열,depth면)
var1 #3차원 이상은 잘 사용하지 않고, 4차원 이상으로는 하지 않는편이 낫다












