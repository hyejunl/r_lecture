
# 사용하는 데이터는 
# 한국보지패널데이터

# 한국보건사회연구원 => 2006부터 10년간 7000여 가구에 대한 경제활동, 생활실태, 복지욕구 등등등

# 파일을 복사해야 해요!
# 제공받은 데이터 파일은 SPSS 파일이에요!

install.packages("foreign") #spss파일 불러들이는 패키지
library(foreign)

# 필요한 package를 미리 로딩
library(stringr)
library(ggplot2)
library(dplyr)
library(xlsx)

# 사용할 raw data를 불러와요!
raw_data_file = "C:/lecture2/data/Koweps_hpc10_2015_beta1.sav"

raw_welfare <- read.spss(file=raw_data_file,
                         to.data.frame = T) #데이터 프레임으로 바꿔서 갖고와

# 원본 raw파일은 보존해 놓아요!!
welfare <- raw_welfare

str(welfare) # 'data.frame':	16664 obs. of  957 variables:

# 데이터 분석에 필요한 컬럼은 컬럼명을 변경해줄거에요
# 코드표에 있는 데이터만 분석 

welfare <- rename(welfare,
                  gender=h10_g3, #성별
                  birth=h10_g4,  #출생연도
                  marrige=h10_g10, #혼인상태
                  religion=h10_g11, #종교(유무)
                  code_job=h10_eco9, #직종 sheet2의 직종코드와 join하기 쉽게 
                  income=p1002_8aq1, #일한달의 월 평균 임금
                  code_region=h10_reg7) #7개 권역별 지역구분

#####################################################준비완료

# 1. 성별에 따른 월급 차이

table(welfare$gender) #빈도를 조사해보니 무응답인 9값은 안나오는거보니 이상치가 없구나아~

# 1은 male로 변경하고 2는 female로 변경

welfare$gender <- ifelse(welfare$gender==1,
                         "male",
                         "female")

table(welfare$gender)

class(welfare$income) #월급에 대한 데이터 타입 "numeric" (vector이면서 numeric)

summary(welfare$income) #기본통계량 확인
# NA's =>12030 NA값이 이렇다 
# 중간값이 평균보다 낮다 => 빈곤층이 많다

qplot(welfare$income)+ #중간에 그래프로 빈도 확인 
  xlim(0,1000) #월급 0부터 1000까지
# 0~250만원 사이에 가장 많은 사람들이 분포하고 있네요!!

#월급에 대한 이상치(0,9999)부터 처리

welfare$income = ifelse(welfare$income %in% c(0,9999),
                        NA,
                        welfare$income)
# NA가 몇개 있는지 확인
table(is.na(welfare$income))

#### 분석을 하기 위한 준비가 끝나요!

gender_income <- welfare %>%
  filter(!is.na(income))%>% #income이 NA가 아닌것만 추출
  group_by(gender)%>%
  summarise(mean_income=mean(income))

gender_income<-as.data.frame(gender_income)
gender_income

## 결과 데이터 프레임을 얻었으니 이제 그래프를 그려보아요!!
ggplot(data=gender_income,
       aes(x=gender,
           y=mean_income))+
  geom_col(width = 0.5, #col은 factor, bar는 전체 데이터에서 빈도 구할때
           fill=c("red","blue")) + 
  labs(x="성별",
       y="평균 월급",
       title="성별에 따른 월급 차이",
       subtitle="남성이 여성보다 150만원 많이 벌어요!!",
       caption="Example 1 Fig.")+ #전체 그래프에 대한 설명 오른쪽 아래
  theme(plot.title = element_text(size = 30, hjust = 0.5))

####################################################################

# 2. 나이와 월급의 관계 파악
# 몇살때 월급을 가장 많이 받을까?
# 2015년도를 기준으로 53살에 318.6777만원을 받아요!!
# 나이에 따른 월급을 선그래프로 표현
welfare$birth = ifelse(welfare$birth == 9999,
                       NA,
                       welfare$birth)

welfare$income = ifelse(welfare$income %in% c(0,9999),
                        NA,
                        welfare$income)

welfare_age<-welfare%>%
             mutate(age=2015-welfare$birth+1)

age_income<- welfare_age%>%
             filter(!is.na(income),
                    !is.na(age))%>%
             group_by(age)%>%
             summarise(mean_income=mean(income))

age_income<- as.data.frame(age_income)

tmp<-age_income%>%
     filter(mean_income==max(mean_income))
tmp

ggplot(data=age_income,
       aes(x=age,
           y=mean_income))+
  geom_line()+
  labs(x="나이",
       y="평균 월급",
       title="나이에 따른 월급 차이")+
  theme(plot.title = element_text(size = 30, hjust = 0.5))
 #+geom_vline(xintercept = tmp$age, color="red")

##############선생님풀이###############################
class(welfare$birth) # 출생연도(숫자)
summary(welfare$birth)
qplot(welfare$birth) # 빈도를 알 수 있어요
# 나이에 대해 결측치가 있나 확인
table(is.na(welfare$birth)) # 결측치 없어요

# 이상치(9999)도 check해야 해요
welfare$birth = ifelse(welfare$birth==9999,
                       NA,
                       welfare$birth)
table(is.na(welfare$birth))

# 나이에 대한 column이 없기 때문에 존재하지 않기 때문에 column을 생성해야 해요!
welfare<- welfare %>%
  mutate(age=2015-birth+1)
summary(welfare$age)
qplot(welfare$age)

age_income<-welfare %>% 
  filter(!is.na(income))%>%
  group_by(age)%>%
  summarise(mean_income= mean(income))

head(age_income)

age_income = as.data.frame(age_income)
# 가장 월급을 많이 받는 나이는?
age_income %>% arrange(desc(mean_income))%>%
  select(age)%>% head(1)

# 나이에 따른 월급을 선그래프로 표현
ggplot(data=age_income,
       aes(x=age,
           y=mean_income)) +
  geom_line()

#################################################################

# 3. 연령대에 따른 월급 차이
# 30대 미만 : 초년(young)
# 30~59세 : 중년(middle)
# 60세 이상 : 노년(old)

# 위의 범주로 연령대에 따른 월급 차이 분석
# 위에서 했던 나이에 따른 월급 차이와 크게 다른점은 없어요...

# 연령대라는 새로운 column을 추가해야 해요!
welfare<-welfare%>%
  mutate(age_group= ifelse(age<30,
                           "young",
                           ifelse(age<60,
                                  "middle",
                                  "old")))
table(welfare$age_group)

age_group_income<-welfare%>%
  filter(!is.na(income))%>%
  group_by(age_group)%>%
  summarise(mean_income=mean(income))

age_group_income<-as.data.frame(age_group_income)

age_group_income

ggplot(data=age_group_income,
       aes(x=age_group,
           y=mean_income)) +
  geom_col(width=0.5)

# ggplot은 막대 그래프를 그릴 때 기본적으로 x축 데이터에 대해 알파벳 오름차순으로 정렬해서 출력

#막대 그래프 크기로 순서를 바꿀려면 (작은것부터 앞으로 나오게)
ggplot(data=age_group_income,
       aes(x=reorder(age_group,mean_income),
           y=mean_income)) +
  geom_col(width=0.5)

# 큰 것부터 앞으로 나오게
ggplot(data=age_group_income,
       aes(x=reorder(age_group,-mean_income),
           y=mean_income)) +
  geom_col(width=0.5)


# 막대그래프의 x축 순서를 내가 원하는 순서로 바꿀려면 어떻게 해야 하나요?

ggplot(data=age_group_income,
       aes(x=age_group,
           y=mean_income)) +
  geom_col(width=0.5)+
  scale_x_discrete(limits=c("young","middle","old")) #x축 막대가 나오는 순서 정해주기

#################################################################

#4. 연령대 및 성별의 월급 차이를 알아보아요

# 초년 여자
# 초년 남자
# 중년 여자
# 중년 남자
# 노년 여자
# 노년 남자

gender_age_income <- welfare%>%
  filter(!is.na(income))%>%
  group_by(age_group,gender)%>%
  summarise(mean_income=mean(income))
gender_age_income <- as.data.frame(gender_age_income)

# 누적 차트로 표현해야 될 듯 해요!!
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income)) +
  geom_col(aes(fill=factor(gender)))+
  scale_x_discrete(limits=c("young","middle","old"))


ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender)) +
  geom_col()+
  scale_x_discrete(limits=c("young","middle","old"))

#위도 되고 아래도 되고!!

#누적을 옆으로 빼서 보기 편하게 dodge시키기
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender)) +
  geom_col(position="dodge")+
  scale_x_discrete(limits=c("young","middle","old"))


####### dcast 그냥 해봤음
library(reshape2)
try1<-dcast(gender_age_income,
      formula=age_group~gender,
      value.var = "mean_income")
try1
#age_group    female     male
#1    middle 187.97552 353.0757
#2       old  81.52917 173.8556
#3     young 159.50518 170.8174

###############################################################

#5. 나이 및 성별에 따른 월급 차이 분석
# 성별의 월급차이는 연령대에 따라 다른 양상을 보일 수도 있을듯 함

gender_age_income2<-welfare%>%
                    filter(!is.na(income))%>%
                    group_by(age,gender)%>%
                    summarise(mean_income=mean(income))

gender_age_income2<-as.data.frame(gender_age_income2)

ggplot(data=gender_age_income2,
       aes(x=age,
           y=mean_income,
           color = gender))+
  geom_line()

ggplot(data=gender_age_income2,
       aes(x=age,
           y=mean_income,
           col = gender))+ #gender col로 분리해서 그리겠다
  geom_line(size=1) #size로 굵기 조정

################################################################

# 6. 직업별 월급 차이를 분석
# 가장 월급을 많이 받는 직업은?
# 가장 월급을 적게 받는 직업은?

welfare$code_job<-ifelse(welfare$code_job==9999,
                         NA,
                         welfare$code_job)
sum(is.na(welfare$code_job))


job_income<-welfare%>%
  filter(!is.na(welfare$code_job),
         !is.na(income))%>%
  group_by(code_job)%>%
  summarise(mean_income=mean(income))%>%
  arrange(desc(mean_income))
job_income<-as.data.frame(job_income)
job_income



code<-read.xlsx(file="C:/lecture2/data/Koweps_Codebook.xlsx",
                sheetIndex = 2,
                encoding="UTF-8",
                header = T)

full_data<-left_join(job_income,code)
full_data<-as.data.frame(full_data)
head(full_data)  
tail(full_data,10)

f<-full_data%>%
   filter(mean_income %in% c(max(mean_income),min(mean_income)))%>%
   select(job,mean_income)


ggplot(data=f,
       aes(x=job,
           y=mean_income))+
  geom_col(fill=c("red","blue"))

# 그래프를 다 그린다음..(막대그래프)
ggplot(data=full_data,
       aes(x=job,
           y=mean_income))+
  geom_col()+
  coord_flip()+ #x축,y축 바꿔줌
  theme(axis.text.y = element_text(size=7))
###################################################################

# 7. 종교 유무에 따른 이혼률
# 종교가 있는 사람이 이혼을 덜 할까?

# 이혼여부를 나타내는 컬럼을 만들어야 할 것 같아요!!
# ex) group_marrige
# 만약 1,2,4이면 group_marriage => marriage
# 만약 3이면 group_marriage => divorce

table(welfare$religion)
welfare$religion<- ifelse(welfare$religion==1,"Y","N")

table(welfare$marrige) #3번 이혼 (1,2,3,4 중에서)

religion_div<-welfare%>%
  select(religion,marrige)%>%
  filter(marrige%in%c(1:4))%>%
  group_by(religion)%>%
  summarise(rate=sum(marrige==3)/length(marrige))

religion_div<-as.data.frame(religion_div)
religion_div$rate<-religion_div$rate*100 #%로 나타내기 위해



ggplot(data=religion_div,
       aes(x=religion,
           y=rate))+
  geom_col(width=0.5)+
  geom_text(aes(label=str_c(round(rate,2),"%"), #소숫점 두자리에 %붙이기
                      vjust=-0.5,  
                      hjust=-0.2)) 

############################선생님 풀이

# 1. 새로운 column을 만들어 보아요!
welfare<- welfare%>%
  mutate(group_marriage = 
           ifelse(marrige%in%c(1,2,4),
                  "marriage",
                  ifelse(marrige==3,
                         "divorce",
                         NA)))
table(welfare$group_marriage)         

religion_divorce <- welfare %>%
  filter(!is.na(group_marriage))%>%
  group_by(religion, group_marriage)%>%
  summarise(n=n()) %>%
  mutate(total_n = sum(n))%>% #group by를 religion으로 해서 sum 하면 religion이 같은것끼리의 sum을 구하게 된다
  mutate(pct=round(n/total_n*100,1))%>%#*100 하고 round로 소숫점 제한
  arrange(desc(pct))


ggplot(data=religion_divorce,
       aes(x=religion,
           y=pct,
           fill=pct))+
  geom_col()





