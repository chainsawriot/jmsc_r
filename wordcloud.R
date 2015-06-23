require(tm)
require(wordcloud)

cons <- read.csv("cons.csv", stringsAsFactors = FALSE)
str(cons)

cons[1,1]
require(jiebaR)
cutter <- worker()
#cutter <= cons[1,1]
segment(cons[1,1], cutter)
require(tm)
Corpus(VectorSource(cons$x))

segcons <- sapply(cons$x, function(x) paste(segment(x, cutter), collapse = " "))

Corpus(VectorSource(segcons)) %>% DocumentTermMatrix(control = list(wordLengths=c(1, Inf))) -> consDTM

apply(consDTM, 2, sum)

weightTfIdf(consDTM) %>% apply(2, sum) -> tfidfcons


wordcloud(words = names(tfidfcons), freq = tfidfcons, min.freq = 1, random.order = FALSE, colors = c('yellow', 'orange', 'red'))


dtmwordcloud <- function(dtm, min.freq = 1) {
    tfidffreq <- apply(weightTfIdf(dtm),2,sum)
    wordcloud(words = names(tfidffreq), freq = tfidffreq, min.freq = min.freq, random.order = FALSE, colors = c('yellow', 'orange', 'red'))
}

Corpus(VectorSource(segcons)) %>% DocumentTermMatrix(control = list(wordLengths=c(1, Inf))) %>% dtmwordcloud(min.freq = 2)
