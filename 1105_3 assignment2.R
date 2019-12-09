# data : excel 파일(exec1105.xlsx)

# 만약 결측값이 존재하면 결측값은 결측값을 제외한 
# 해당 과목의 평균을 이용합니다.
library(xlsx)
library(ggplot2)
help("read.xlsx")
sheet1<-read.xlsx(file="C:/lecture2/data/exec1105.xlsx",
                  sheetIndex = 1,
                  encoding="UTF-8",
                  header=F)
sheet2<-read.xlsx(file="C:/lecture2/data/exec1105.xlsx",
                  sheetIndex = 2,
                  encoding="UTF-8",
                  header=F)
library(ggplot2)
library(stringr)
library(dplyr)
library(reshape2)

score_df<-sheet1%>%
  rename(id=X1,
         subject=X2,
         score=X3)
sheet2_df<-sheet2%>%
  rename(id=X1,
         name=X2,
         gender=X3)

score_df2<- dcast(score_df,
                  formula = id ~subject,
                  value.var = "score")

for (i in length(score_df2)){
  score_df2[,i][is.na(score_df2[,i])]<-mean(score_df2[,i],na.rm=T)
}

score_df2

# 만약 극단치가 존재하면 하위 극단치는 극단치값을 제외한
# 해당 과목의 1사분위 값을 이용하고 상위 극단치는
# 해당 과목의 3사분위 값을 이용합니다.
####
summary(score_df2)
box<-boxplot(score_df2) $stats 
box
for(i in 2:length(score_df2)){
  score_df2[,i][score_df2[,i]>box[5,i]]<-box[4,i]
  score_df2[,i][score_df2[,i]<box[1,i]]<-box[2,i]
}
score_df2
boxplot(score_df2)

#####
f_df<-left_join(score_df2,sheet2_df)
f_df



# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?
f_df%>%
  mutate(avg_score=(eng+kor+math)/3)%>%
  filter(avg_score==max(avg_score))%>%
  select(name,avg_score)



# 2. 남자와 여자의 전체 평균은 각각 얼마인가요?
f_df%>%
  mutate(avg_score=(eng+kor+math)/3)%>%
  group_by(gender)%>%
  summarise(mean(avg_score))



# 3. 수학성적이 전체 수학 성적 평균보다 높은 남성은 누구이며
#    수학성적은 얼마인가요?
f_df%>%
  filter(math>mean(math),
         gender=="남자")%>%
  select(name,math)












