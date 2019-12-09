### HTML, CSS, JavaScript 웹 언어!

# w3c
# HTML이 발전발전 해서 1999년 4.01 버전
# w3c가 1999년 12월에 HTML 4.01을 마지막으로 더이상 HTML의 버전없은 없어!
# HTML언어는 기본적으로 2가지 문제점을 가지고 있어요!
# 1. 정형성이 없어요! => 유지보수시에 문제점이 발생하게 되요!
# 2. 확장성이 없어요! => 정해진 tag만 이용해서 사용하다보니 배우고 쓰기는 쉽지만 응용해서 확장하기에는 적합하지 않아요!

# 2000년 부터 w3c는 HTML 표준을 다른 것을 가미해서 위의 2가지 문제를 해결하려 해요!
# XML을 HTML에 도입해서 표준으로 끌고 가려해요!
# XHTML 1.0이 시작
# XML 사용에 회의적인 시각을 가지고 있는 몇몇 회사들이 컨소시엄을 구성
# XML 대신 HTML을 발전시켜보자!! => HTML5
# HTML5의 의의 : 웹페이지 대신 웹 어플리케이션이 대세가 될거예요!!
# 웹페이지대신 Front-End Web Application을 사용하게 되요!
# Angular, react.js, View.js => JavaScript

# html
# 포함시키는 것 부모, 포함되는 것 자식
# 2개의 자식 : head ->설정, body-> 내용
# indent(들여쓰기) 잡아서 포함관계를 표현해 주는 것이 보기가 좋다
# 부모와 자식은 바로 그 안에 포함되어 있는 것
# html에게 h1은 후손, body에게 h1은 자식, body와 head는 형제
# tag는 block element:한 라인(DIV), inline element: tag의 길이 만큼만(span)
# input의 태그, type는 속성
# 디렉토리로 폴더만들어서 이미지들 복붙으로 저장
# <img src="./image/bbang.jpg"> 이미지 넣기기
# <br>은 강제 줄바꿈
# <head><style> =>CSS를 이용해서 디자인
#<style>
#  li {
#    color : red;
#    background-color : yellow;
#  
#  }
#</style>
# 동적영역 => JavaScript

### 10/25

# 입력으로 최대 100자의 문자열을 이용 (영문자, 숫자)

# 입력으로 사용된 문자열에서 숫자만을 추출해서 출력하세요!

#예}"Hi2567Hello23kaka890L34TT23"
#   =>"2567238903423"
# 이렇게 추출한 숫자문자열에서 갯수가 가장 많은 숫자를 찾아서 숫자와 출현빈도를 출력하세요!
# 만약 출현빈도가 같은 숫자가 여러개인 경우
# 그중 가장 작은 숫자와 출현빈도를 출력하세요.
# 2->3, 3->3, 4->1, 5->1, 6->1

require(stringr)

#input<- "Hi2567Hello23kaka890L34TT23" #scan
myFunc=function(input){

var1 <- str_extract_all(input,"[0-9]") ;var1
var2 <- paste(var1[[1]],collapse="") ;var2

result=c()
for (i in 0:9){
  result[i+1]<-sum(var1[[1]]==i)
  }
result


i=1
while(result[i]!=max(result)){
  i=i+1
}
i-1

cat("숫자만 추출:",var2,"갯수많은 숫자:",i-1, "출현빈도:",max(result))
}

myFunc(scan(what=character()))








 