# R Graph 
# 숫자나 문자로 표현하는 것보다는 그림(그래프)로 표현하면 변수의 관계 데이터 경향을 좀 더 쉽게 파악할 수 있어요!

# 해들리 위컴
# reshape2 package
# dplyr package
# ggplot2 package R에서 가장 많이 사용.

# 산점도 (변수간의 관계, 데이터 경향)
# 막대그래프(일반, 빈도(누적),히스토그램)
# 선그래프 (시계열 데이터 표현)
# box 그래프 (데이터의 분포)


# mpg data set을 그냥 사용해 보아요!
######### 산점도 (scatter) - 변수간의 관계를 파악 

# ggplot2는 3단계로 그래프를 그려요!
# 1. 축을 정해요! 배경을 설정
# 2. 그래프를 추가해요!
# 3. 축 범위, 배경 설정
library(ggplot2)
df <- as.data.frame(mpg)

ls(df)
# 1. 배경 설정
# data설정 : 그래프를 그리는데 필요한 데이터 
# aes(x=, y=) : 축 설정

# 배기량에 따른 고속도로 연비
ggplot(data=df,  #데이터는 df를 이용할거야
       aes(x=displ, #x축은 배기량
           y=hwy))+ #y축은 고속도로 연비 #+기호로 chaining
  geom_point()      # 산점도를 그려요

# 우리가 원하는 그래프를 그릴 수 있어요
#=> 우하향 그래프를 통해 displ이 증가하면 hwy가 감소하는 것을 알 수 있다

# 설정을 추가할 수 있어요!
ggplot(data=df,  
       aes(x=displ, 
           y=hwy))+ 
  geom_point(size=3, color="red") + #점의 크기가 3, 색이 빨강으로 바뀜
  xlim(3,5) + #x축의 범위를 3부터 5로
  ylim(20,30) #y축의 범위를 20부터 30으로

plot.new() # plot창에 그렸던 그림을 초기화 시켜줌

######################################################################

########## 막대그래프 - 집단간의 비교를 할 때
# 집단간의 비교를 할 때 많이 사용되요!

# 구동방식(drv) : f(전륜), r(후륜), 4(4륜) (범주형 데이터)

# 연비를 비교해 보아요!

# 막대 그래프를 그리기 위해서 데이터를 준비해야 해요!

# 구동방식별 고속도로 연비 차이(평균)를 알고 싶어요!
library(dplyr)
df <- as.data.frame(mpg)
result <- df%>%
          group_by(drv)%>%
          summarise(avg_hwy=mean(hwy))
class(result) #[1] "tbl_df"     "tbl"        "data.frame" 
result <- as.data.frame(result)
result # 구동방식별 고속도로 연비 평균

ggplot(data=result,
       aes(x=drv,
           y=avg_hwy)) +
  geom_col(width=0.5,fill="pink",color="red")      #bar는 빈도 구하는 함수, col이 막대 그래프

# 막대그래프의 길이 따라서 순서를 재배치하려면
ggplot(data=result,
       aes(x=reorder(drv,avg_hwy), #x축의 순서를 바꿀건데 avg_hwy크기에 따라 작은 순서로 reorder 할거야 
           y=avg_hwy)) +
  geom_col()

ggplot(data=result,
       aes(x=reorder(drv,-avg_hwy), #x축의 순서를 바꿀건데 avg_hwy크기에 따라 큰 순서대로 reorder 할거야 
           y=avg_hwy)) +
  geom_col()
  

# 빈도 막대 그래프
# 사용하는 함수는 geom_bar()
# raw data frame을 직접 이용해서 처리 (group_by, summary 할필요 NONO)
ggplot(data=df,   # df파일을 직접 사용
       aes(x=drv)) + #y축을 설정해줄 필요 nono
  geom_bar()

# 빈도 막대 그래프 구할 때 사용하는 함수와 사용방법
head(df)

# 누적 빈도 그래프

ggplot(data=df,   
       aes(x=drv)) + 
  geom_bar(aes(fill=factor(cyl))) #밀도 막대 안에서 다시 축을 잡아서 누적 빈도 그래프 그리기

ggplot(data=df,   
       aes(x=drv)) + 
  geom_bar(aes(fill=factor(trans)))

ggplot(data=df,   
       aes(x=drv)) + 
  geom_bar(aes(fill=factor(class)))

# 히스토그램 (구간에 몇개 있느냐? 구간당 분포)
# x축이 연속형 변수여야 해요
ggplot(data=df,   
       aes(x=hwy)) + #히스토그램을 그릴때는 x축이 연속형 데이터 
  geom_histogram(bins=10) # 구간 갯수 설정은 bins, 구간 너비 설정은 binwidth
# 간격을 설정해주지 않으면 30개 구간으로 자름


#######################################################################


########## 선 그래프 - 시간에 따라 변화하는 시계열 데이터를 표현할 때
# 일반적으로 환율, 주식, 경제동향

# mpg는 시간에 대한 데이터가 없어요
# line chart를 위해서 economics data set을 이용

tail(economics)
# pop: 인구수 (1000명단위)
# psaert : 월별 개인 저축비율
# uempmed : 얼마나 오랫동안 구직활동을 하고 있느냐 (주단위)
# umeploy : 실업자수 (100명단위)
# pce : 개인 소비지출 (10억단위) 


ggplot(data=economics,
       aes(x=date,  # data type의 date
           y=unemploy))+
  geom_line()


# 산점도와 선 그래프를 같이 표현하기 
ggplot(data=economics,
       aes(x=date,  
           y=unemploy))+
  geom_point(color="red")+
  geom_line()



######################################################################
############ 박스 그래프 - 데이터의 분포를 파악

df <- as.data.frame(mpg)
head(df)

# 구동 방식별 hwy(고속도로 연비)
# 상자그림을 그려보아요!

ggplot(data=df,
       aes(x=drv,
           y=hwy))+
  geom_boxplot()

######################################################################
# 이렇게 ggplot2를 이용해서 4가지 종류의 그래프를 그릴 수잇어요!
# 여기에 추가적인 객체를 포함시켜서 그래프를 좀 더 이해하기 쉬운 형태로 만들어 보아요!!

# mpg : 자동차 연비에 대한 data set 
# economics : 월별 경제 지표에 대한 data set

# 날짜별 개인저축률에 대한 선 그래프를 그려보아요!
# 일반적인 직선을 그릴 수 있어요!

ggplot(data=economics,
       aes(x=date,
           y=psavert)) + 
  geom_line() +
  geom_abline(intercept = 12.1,
              slope = -0.0003444) #기울기와 절편을 지정해줘야 선그래프가 그려짐

# 수평선을 그릴 수 있어요!
ggplot(data=economics,
       aes(x=date,
           y=psavert)) + 
  geom_line() +
  geom_hline(yintercept=mean(economics$psavert)) #y쪽 절편이 저축률 전체 평균 


# 수직선을 그릴 수 있어요!
# 가장 개인 저축률이 낮은 날짜에 대한 수직선을 그릴려고 해요!
tmp<-economics%>%
          filter(psavert==min(economics$psavert))%>%
          select(date)
tmp <- as.data.frame(tmp)
result<-tmp$date #tmp가 dataframe이기 때문에 안의 값만 뽑아내는 처리를 해야함

ggplot(data=economics,
       aes(x=date,
           y=psavert)) + 
  geom_line() +
  geom_vline(xintercept=result) 

## 만약 직접 날짜를 입력해서 수직선을 표현하려면?
ggplot(data=economics,
       aes(x=date,
           y=psavert)) + 
  geom_line() +
  geom_vline(xintercept=as.Date("2005-05-01")) #이렇게 하면 "2015-05-01"가 날짜 데이터가 아니라 character형식이기 때문에 as.Date로 데이터 타입을 바꿔서 넣어줘야 한다

######################################################################

## 그래프 안에서 text를 표현하려면 어떻게 해야 하나요?

ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_point() +
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) +
  ylim(7,10) +
  geom_text(aes(label=psavert, #psavert를 text로 나타내겠다
                vjust=-0.5,  #글자의 상하위치 조정 (양수면 아래, 음수면 위)
                hjust=-0.2)) #글자의 좌우위치 조정 (양수면 왼쪽, 음수면 오른쪽)
  
### 그래프안에서 주목해야할 영역을 highlighting하려면 어떻게 하나요?

ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_point() +
  annotate("rect", #덧붙일거야 (화살표, hightlight 영역 등등) "사각형"을
           xmin=as.Date("1991-01-01"), #x 최소
           xmax=as.Date("2005-01-01"), #x 최대
           ymin=5, #y 최소
           ymax=10, #y 최대
           alpha=0.3, #투명도 (0이면 완전 투명, 1이면 완전 불투명) 
           fill="red") 

### 여기에 추가적으로 화살표도 넣어보기
ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_point() +
  annotate("rect", 
           xmin=as.Date("1991-01-01"), 
           xmax=as.Date("2005-01-01"), 
           ymin=5, 
           ymax=10, 
           alpha=0.3,  
           fill="red") +
  annotate("segment",
           x=as.Date("1985-01-01"),   #x시작
           xend=as.Date("1995-01-01"), #x 끝
           y=7.5,
           yend=8.5,
           arrow=arrow(), #화살표 모양이야 
           color="blue") +
  annotate("text",
           x=as.Date("1985-01-01"),
           y=15,
           label="소리없는 아우성!!")

#차트제목, column명 
ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_point() +
  annotate("rect", 
           xmin=as.Date("1991-01-01"), 
           xmax=as.Date("2005-01-01"), 
           ymin=5, 
           ymax=10, 
           alpha=0.3,  
           fill="red") +
  annotate("segment",
           x=as.Date("1985-01-01"),   #x시작
           xend=as.Date("1995-01-01"), #x 끝
           y=7.5,
           yend=8.5,
           arrow=arrow(), #화살표 모양이야 
           color="blue",size=2) + #색은 파랑, 크기는 2
  annotate("text",
           x=as.Date("1985-01-01"),
           y=15,
           label="소리없는 아우성!!")+
  labs(x="연도",y="개인별 저축률",           # x축, y축 이름 지정
       title="연도별 개인저축률 추이") +     # 차트 이름
  theme_classic()   #테마지정할 수 있다 #classic은 격자를 날린다.










