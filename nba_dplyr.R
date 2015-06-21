# grammar of data manipulation
# and data pipelining

nba <- read.csv('nba2013.csv', stringsAsFactors = FALSE)

require(dplyr)
require(magrittr)

colnames(nba)
str(nba)

nba

nba <- tbl_df(nba)

nba


# selection using filter

filter(nba, POS == "C", X3P > 0) 

# arrange: sorting

arrange(nba, PTS)

arrange(nba, desc(PTS))

# select: select column

select(nba, PLAYER, PTS)

# distinct(select(nba, PLAYER))

# create new column with mutate

# X3PP = X3P / X3PA , 3 points percentage =  3 points sucess / 3 points attempted

mutate(nba, X3PP = X3P / X3PA)

select(mutate(nba, X3PP = X3P / X3PA), X3PP) # why not a NaN?

# summarise, get the summary statistics

summarise(nba, medianPTS = median(PTS), meanPTS = mean(PTS))

## TASK 1: filter player with non-zero X3PA, calculate X3PP and sort players by X3PP

nonznba <- filter(nba, X3PA > 0)
nonznba <- mutate(nonznba, X3PP = X3P / X3PA)
arrange(nonznba, desc(X3PP)) # what is the problem?

arrange(nonznba, desc(X3PA), desc(X3PP))

# want to extract the sorted PLAYER, TM, X3P, X3PA and X3PP!
# so tedious!


## introducing the concept of pipeline, the 'then' operator %>%

nba %>% filter(., X3PA > 0)

### effectively, equal to
filter(nba, X3PA > 0)

### if the placement is in first position, you can skip the dot

nba %>% filter(X3PA > 0)

nba %>% filter(X3PA > 0) %>% mutate(X3PP = X3P / X3PA)

# mutate(filter(nba, X3PA > 0), X3PP = X3P / X3PA)

nba %>% filter(X3PA > 0) %>% mutate(X3PP = X3P / X3PA) %>% arrange(desc(X3PA), desc(X3PP))
nba %>% filter(X3PA > 0) %>% mutate(X3PP = X3P / X3PA) %>% arrange(desc(X3PA), desc(X3PP)) %>% select(PLAYER, TM, X3P, X3PA, X3PP)

# if you need all data

nba %>% filter(X3PA > 0) %>% mutate(X3PP = X3P / X3PA) %>% arrange(desc(X3PA), desc(X3PP)) %>% select(PLAYER, TM, X3P, X3PA, X3PP) %>% data.frame

# group_by

nba %>% group_by(TM)

nba %>% group_by(TM) %>% summarise(totalPTS = sum(PTS))

nba %>% group_by(TM) %>% summarise(totalPTS = sum(PTS)) %>% arrange(desc(totalPTS))

# more group_by

nba %>% group_by(TM) %>% summarise(totalPTS = sum(PTS), totalMIN = sum(MIN)) %>% arrange(desc(totalPTS))

nba %>% group_by(TM) %>% summarise(totalPTS = sum(PTS), totalMIN = sum(MIN)) %>% mutate(PTSpMIN = totalPTS / totalMIN)

nba %>% group_by(TM) %>% summarise(totalPTS = sum(PTS), totalMIN = sum(MIN)) %>% mutate(PTSpMIN = totalPTS / totalMIN) %>% arrange(desc(PTSpMIN))

# even more group_by

nba %>% group_by(POS, nozX3PA = X3PA > 0)

nba %>% group_by(POS, nozX3PA = X3PA > 0) %>% summarise(nplayers = n(), totalPTS = sum(PTS), totalMIN = sum(MIN))

nba %>% filter(X3PA == 0, POS == "SG")

# Q1: which position has the highest PTSpMIN?

# try to pipe that to

require(ggplot2)
ggplot(aes(x = POS, y = PTSpMIN)) + geom_bar(stat = 'identity')

# Q2: Given
nba %>% summarise(bestPlayer = PLAYER[which.max(PTS)], bestscore = PTS[which.max(PTS)])

# calculate the best scoring player for each team and arrange by bestscore

nba %>% group_by(TM) %>% summarise(bestPlayer = PLAYER[which.max(PTS)], bestscore = PTS[which.max(PTS)]) %>% arrange(desc(bestscore))
