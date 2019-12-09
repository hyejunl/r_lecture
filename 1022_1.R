# package
# R은 처음 설치할 때 base package가 같이 설치되요!!
# 추가적인 기능을 이용하기 위해서 외부 package를 찾아서 설치해야 해요!!
# 그래프를 그리기 위해서 많이 사용하는 package는 ggplot2를 이용할 거에요!
# package를 설치하기 위해서 
install.packages("ggplot2") 
#설치된 package를 메모리에 load해야 사용할 수 있어요! 둘 중 하나를 이용해서 로드
library(ggplot2)
require(ggplot2)

# 간단한 빈도를 나타내는 막대그래프를 그리기 위해 vector하나 만들어 보아요!
var1 = c("a","b","c","a","b","a")

# package안의 함수를 이용해서 빈도 그래프를 그려보아요!
qplot(var1)

# 설치된 package를 삭제하려면 (설치된 폴더로 들어가서 직접 삭제하는 것도 가능)
remove.packages("ggplot2")

#package가 설치된 폴더 경로를 알아보아요!
.libPaths()

#package 설치 경로를 변경하고 싶어요!! 
.libPaths("c:/lecture2/lib")
.libPaths()

# 많은 package에 대한 정보, 사용법 등을 알면 알수록 R을 잘 사용할 수 있어요!

# package를 설치하면 package에서 제공하는 함수를 이용할 수 있어요!

help(qplot) #함수에 대한 정보를 얻을 수 있는 방법

example(qplot) #함수에 대한 예시를 볼 수 있는 방법 (반드시!! package 다운로드 후 로드를 하고 사용해야 한다)

# working directory (작업하는 폴더의 위치)

getwd()  #working directory 찾는 방법
setwd("c:/leture2/lib/") #working directory 변경하는 방법










