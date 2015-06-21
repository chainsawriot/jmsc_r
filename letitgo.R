require(tm)
require(magrittr)
require(wordcloud)

letitgo <- readLines('letitgo.txt')

tolower(letitgo)

Corpus(VectorSource(tolower(letitgo))) %>% DocumentTermMatrix

# ?termFreq

Corpus(VectorSource(tolower(letitgo))) %>% DocumentTermMatrix(control = list(wordLengths=c(1, Inf))) -> letitgodtm

inspect(letitgodtm[1,])

Corpus(VectorSource(tolower(letitgo))) %>% DocumentTermMatrix(control = list(wordLengths=c(1, Inf), removePunctuation = TRUE)) -> letitgodtm

inspect(letitgodtm[1,])

apply(letitgodtm,1,sum)
apply(letitgodtm,2,sum)

sort(apply(letitgodtm,2,sum))
weightTfIdf(letitgodtm)

sort(apply(weightTfIdf(letitgodtm),2,sum))
tfidffreq <- apply(weightTfIdf(letitgodtm),2,sum)

wordcloud(words = names(tfidffreq), freq = tfidffreq, min.freq = 0)

wordcloud(words = names(tfidffreq), freq = tfidffreq, min.freq = 1, random.order = FALSE, colors = c('yellow', 'orange', 'red'))
