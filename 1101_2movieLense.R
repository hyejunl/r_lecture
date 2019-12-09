ratings<-read.csv(file="C:/Users/student/Downloads/ml-latest-small/ml-latest-small/ratings.csv")
movies<-read.csv(file="C:/Users/student/Downloads/ml-latest-small/ml-latest-small/movies.csv")
ls(ratings)
library(dplyr)

# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
mean(ratings$rating) #[1] 3.501557


# 2. 각 사용자별 평균 평점
user_avg_rating<- group_by(ratings,
                           userId)%>%
                  summarise(mean(rating))

# 3. 각 영화별 평균 평점
#full_data<-full_join(ratings,movies)
#View(full_data)


movie_avg_rating<- group_by(ratings,
                            movieId)%>%
                   summarise(mean_rating=mean(rating))
View(movie_avg_rating)
ls(movie_avg_rating)

# 4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로 정렬해서 출력
#    (동률이 있는 경우 모두 출력)



rank_title<- left_join(movie_avg_rating,movies)%>%
             filter(mean_rating==max(mean_rating))%>%
             arrange(desc(title))%>%
             select("title")
sum(is.na(df)) #결측값이 0이여야 함

View(rank_title)  


# 5. comedy 영화 중 가장 평점이 낮은 영화의 
#    제목을 오름차순으로 출력
#    (동률이 있는 경우 모두 출력)
comedy_min<-left_join(movie_avg_rating,movies)%>%
            filter(grepl('Comedy',genres))%>%
            filter(mean_rating==min(mean_rating))%>%
            arrange(title)%>%
            select("title")
View(comedy_min)



#filter(mtcars, grepl('Toyota|Mazda', type))
#filter(df,grepl("문자열",column이름)) => 문자열이 포함된 행만 필터링



# 6. 2015년도에 평가된 모든 Romance영화의 평균 평점 출력 **R timestamp 구글링
# as.POSIXct(timestamp데이터프레임, origin="1970-01-01")
date_data<-mutate(ratings,
                 date=as.POSIXct(ratings$timestamp, origin="1970-01-01"))%>%
           filter(grepl('2015',date))

final<-left_join(date_data,movies)%>%
       filter(grepl('Romance',genres))
View(final)

mean(final$rating) #[1] 3.396375


#final<-left_join(date_data,movies)%>%
#  filter(grepl('Romance',genres))%>%
#  group_by(movieId)%>%
#  summarise(mean(rating))%>%
#  left_join(movies)









