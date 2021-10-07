

library("RDSTK")
library("readr")
library("qdap")
library("syuzhet")
library("ggplot2")
library("dplyr")


NF_raw = read_file("assets/NF_raw.txt")
View(NF_raw)


## polarity and sentiment
nf_scores = get_nrc_sentiment(NF_raw)
class(nf_scores)
nf_scores
nf_polarity  = nf_scores[1,9:10]
nf_sentiment = nf_scores[1,1:8]


## visualize polarity
class(nf_polarity)
nf_polarity = data.matrix(nf_polarity, rownames.force = TRUE)
barplot(nf_polarity)


## visualize sentiment
class(nf_sentiment)
nf_sentiment = data.matrix(nf_sentiment, rownames.force = TRUE)
barplot(nf_sentiment)

## break it down by sentence
nf_speech_sen = get_sentences(NF_raw)
nf_speech_sen


sentiment_vector = get_sentiment(nf_speech_sen, method = "syuzhet")

sentiment_vector
summary(sentiment_vector)
boxplot(sentiment_vector)

## what was the most positive sentence?
max(sentiment_vector)
sentence_sentiment = data.frame(nf_speech_sen, sentiment_vector)
View(sentence_sentiment)
which.max(sentence_sentiment$sentiment_vector)

most_positive = sentence_sentiment[which.max(sentence_sentiment$sentiment_vector),]


## what was the most negative sentence?
min(sentiment_vector)
sentence_sentiment = data.frame(nf_speech_sen, sentiment_vector)
View(sentence_sentiment)
which.min(sentence_sentiment$sentiment_vector)

most_negative = sentence_sentiment[which.min(sentence_sentiment$sentiment_vector),]


## wordclouds


library("devtools")
library("RColorBrewer")
library("tm")
library("SnowballC")
library("wordcloud")

wordcloud(NF_raw, colors=c("blue","green"))

