## Real world data
## 1. dirty
## 2. ugly
## 3. damn f ugly
## 4. not ready for analysis

## Real hackers learn by doing.

# RTFM

?mean
help.search("regex")

# singular / scaler

r <- 10
r^2 * 3.1416
r > 100

r <- TRUE
!r
r & FALSE
r & TRUE
r | FALSE

### string manipulation is a larger topic
r <- "hello"
r

# vector (array) and assignment

age <- c(21, 30, 40, 50, 60, 30, 50)
age
teenspirit <- c("An albino", "A mosquito", "My libido", "Yeah", "Hey", "kurt", "cobain")
teenspirit

NANDgatelogic <- c(TRUE, TRUE, FALSE)
NANDgatelogic

# vectorization

age / 10
age > 30 # generate a logical vector
age <= 30 & teenspirit == "An albino"

# indexing

age[1] ## start from 1, not 0
age[-1]
age[3]

# indexing and assignment

teenspirit[1]
teenspirit[1] <- "A mulatto"
teenspirit

###
# Quiz #1: Change the last two elements of the teenspirit vector to "courtney" and "love" (1 min)
# hint: length(c(1,2,3)) will return 3
###

# operation on vector


mean(age)
sd(age)
min(age)
range(age)
cumsum(age)


# data frame: tabular spreadsheet-like data structure
# technically: list of vectors with equal length

gender <- c("M", "F", "M", "F", "F", "F", "M")
gender
participants <- data.frame(gender, age)
participants

# typical operations

head(participants, n = 3)
names(participants) #colnames(participants)
nrow(participants)
ncol(participants)

#data frame indexing: positional
participants$gender
participants[1,]
participants[,1]
participants[c(2,3),2]

#data frame indexing using logical vector

participants$gender == "M"

participants[participants$gender == "M",]

participants$age[participants$gender == "M"]

###
### Quiz #2: Calculation the mean age of Male and Female participants (1 min)
###


## creating new column (variable)

participants$age30 <- participants$age > 30

participants$height <- c(120,120,130,140,142,132,166)
participants

###
### Quiz #3: replace the height column in the participants from cm to inch
### hint: 1 inch = 2.54cm (2 mins)
###

###
### Quiz #4: Explain what is going on with this?
###

participants$age < 40
participants$gender == "F"

participants$age < 40 & participants$gender == "F"

participants[participants$age < 40 & participants$gender == "F",]

###
### Quiz #5.1: read.csv()
### read csv file into a data.frame
### download the Jan csv file from
### http://www.aqhi.gov.hk/en/aqhi/statistics-of-aqhi/past-aqhi-records.html
### look at the help of read.csv
### and try

rubbish <- read.csv("201401_Eng.csv", stringsAsFactors = FALSE)
### you can also use
### rubbish <- read.csv("http://www.aqhi.gov.hk/epd/ddata/html/history/2014/201401_Eng.csv", stringsAsFactors = FALSE)
head(rubbish)

### describe what went wrong and diagnose the reason for this
### hints: you can use unix tools like head (3 mins)
###

###
### Quiz #5.2: how to solve it?
### read ?read.csv. Hints: skip (2 mins)
###

###
### Quiz #5.3: read in the data as a data frame called AQHIraw, look at the data and each group report one problem of the data. (3 mins)
###

KT <- AQHIraw$Kwun.Tong
KT

### data cleansing
## 1a. Removal of "*"
## 1b. Change 10+ to 11
## 2. Date

###
### Quiz 6.1: look up gsub and try to remove "*" in "4*"
### hint: use escape characters for the regex
###

###
### Quiz 6.2: change "10+" to "11" using vector selection and subsitution operations
###

### function definition

cleansing <- function(dirtyaqhi) {

    return(cleanaqhi)
}

KT <- AQHIraw$Kwun.Tong
cleansing(KT)

###
### Quiz 6.3: modify cleansing so that it will also change 10+ to 11
###

### class of data
cleanKT <- cleansing(KT)
class(cleanKT)
mean(cleanKT)

cleanKTnum <- as.numeric(cleanKT)
class(cleanKTnum)
mean(cleanKTnum)

### Quiz 6.4: further modify cleansing so that it will return a numeric vector
### test with

mean(cleansing(AQHIraw$Kwun.Tong))

head(AQHIraw)

### applying the cleansing function across columns

AQHIraw[1:5,3:17]

apply(AQHIraw[1:5,3:17], 2, cleansing)

### concept of higher order function
### function that take another function as argument

### Quiz 7: replace column 3 to 17 in the AQHIraw with the cleansed version
### test with

mean(AQHIraw[,3])
# ?mean for na.rm and try
mean(AQHIraw[,6], na.rm=TRUE)

### Quiz 7.1: calculate the mean score for each region
### the meaning of ... in apply is the additional argument what will be passed to FUN

### Quiz 7.2: which region have the higest mean AQHI?
### hint: ?rank or ?order

### Quiz 7.3: consult ?apply and explain what is going on with:

apply(AQHIraw[, 3:17], 1, mean, na.rm = TRUE)
