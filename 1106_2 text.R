
## 자연어 처리 기능을 이용해 보아요!

## KoNLP package를 이용해요!
# Korean Natural Language Process
# 해당 패키지 안에 사전이 포함되어 있어요!
# 3가지의 사전이 포함
# 시스템 사전 (28만개),
# 세종 사전 (32만개),
# NIADic 사전 (98만개)

# Java기능을 이용해요! 시스템에 JRE가 설치되어 있어야 해요!
# JRE를 성치 하긴 했는데 R package가 JRE를 찾아서 써야해요!
# JAVA_HOME 환경변수를 설정해야 해요!
# 탐색기->내pc 마우스오른쪽버튼 속성->고급시스템설정->환경변수->아래 새로만들기->변수이름:JAVA_HOME->변수값 :C:\Program Files\Java\jre1.8.0_231 (jre가 깔려있는 폴더 찾아서 경로 복사)-> 환경변수 바꾼후에는 r 껐다가 키기

# 참고로 영문 NLP => openNLP, Snowball package를 많이 이용

install.packages("KoNLP")
library(KoNLP)

useNIADic()
extractNoun("소리없는 아우성") # 명사 뽑아내는 함수


txt <- readLines("C:/lecture2/data/hiphop.txt", # 한줄씩 데이터를 읽어오는 함수
                 encoding = "UTF-8") # 한글 인코딩

head(txt)
#"\"보고 싶다"  ->여기서 \는 문자열 "이라는 뜻

# 데이터가 정상적으로 들어왔어요!
# 특수문자가 포함되어 있네?? 제거해주는게 좋아요!

library(stringr)
# 정규표현식을 이용해서 특수문자를 모두 찾아서 " "으로 변환 
txt<- str_replace_all(txt, #찾아서 싹다 바꿔
                      "\\W"," ") #특수문자의 정규표현식 "\\W"
head(txt)

## 형태소를 분석할 데이터가 준비되었어요!

## 함수를 이용해서 명사만 뽑아내요!

nouns <- extractNoun(txt)
head(nouns)

# 명사를 추출해서 list형태로 저장
length(nouns) #list의 길이가 4261

# list형태를 vector로 변환
words<-unlist(nouns) #list를 vector로 변환하는 함수

head(words)
length(words)

# 워드 클라우드를 만들기 위해서 많이 등장하는 명사만 추출

wordcloud <- table(words) #빈도 구하는 함수 : table
class(wordcloud) #[1] "table"

df <- as.data.frame(wordcloud,
                   stringsAsFactors = F) # factor가 아닌 문자열로 받겠다
View(df)

# 두글자 이상으로 되어있는 데이터 중 
# 빈도수가 높은 상위 20개의 단어들만 추출
# (한글자짜리는 의미가 없어요!)

library(dplyr)

word_df <- df%>%
           filter(nchar(words)>=2)%>% #nchar은 문자열의 글자 갯수를 구하는 함수
           arrange(desc(Freq))%>% #빈도수가 높은 순서대로 정렬
           head(20) #상위 20개

# 데이터가 준비되었으니 워드클라우드를 만들어 보아요!
install.packages("wordcloud")
library(wordcloud)           

# 워드 클라우드에서 사용할 색상에 대한 팔레트를 설정
pal <- brewer.pal(8,"Dark2") #Dark2라는 색상목록에서 8개의 색상을 추출

# 워드 클라우드는 만들때마다 랜덤하게 만들어져요
# 랜덤하게 생성되기 때문에 재현성을 확보할 수 없어요!
# 랜덤함수의 시드값을 고정시켜서 항사 같은 워드 클라우드가 만들어지게 설정 
set.seed(1111) #맘에 드는 값으로 시드값을 만듦

word_df
wordcloud(words=word_df$words, # 사용할 단어의 list를 벡터형태로 
          freq=word_df$Freq,
          min.freq=2,    # 최소 빈도는 2
          max.words=20, # 최대 단어수는 20개
          random.order=F,# 고빈도 단어를 중앙 배치 (단어의 위치를 random하게 할까?)
          rot.per = .1, #글자를 회전하는 비율(옆으로 나오게 하는거 0.1)
          scale=c(4,0.3), #단어 크기 비율(큰거는 4, 작은거는 0.3)
          colors=pal) #단어 색깔은 pal잡을 걸루

### 네이버 영화 댓글 사이트에서 특정 영화에 대한 review를 crawling해서 wordcloud를 작성 








