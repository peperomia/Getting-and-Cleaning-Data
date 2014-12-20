library(plyr)
#reading the test files:
subject_test <- read.table(".\UCI HAR Dataset\test\subject_test.txt", header = FALSE, quote = "\"")
X_test <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"")
Y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"")
dim(subject_test); dim(X_test);dim(Y_test)
colnames(subject_test) <- 'subject_id'
colnames(Y_test) <- 'activity'
merged_test <- cbind(subject_test, Y_test)
merged_test2 <- cbind(merged_test, X_test)
merged_test <- merged_test2  #renaming for simplicity, since joining was done in two steps

#reading the train files:
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"")
Y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"")
X_train <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"")
colnames(subject_train) <- 'subject_id'
colnames(Y_train) <- 'activity'
dim(subject_train); dim(Y_train); dim(X_train)



a <- colnames(X_train)
b <- colnames(X_test)

identical(a,b) # checks if two R objects(a and b) are exactly identical - this is hugely 
# important for next step: binding them row-wise. This would much harder to check by eye since
# the X_train and x_test have each 561 variable(unlike subject_ and Y_ file which have 
# only 1 variable)
Pre_merged_train <- cbind(subject_train, Y_train)
merged_train <- cbind(Pre_merged_train, X_train)
identical(names(merged_test), names(merged_train)) #one last check before joining the integrated
# test and train files

allData <- rbind(merged_test, merged_train); dim(allData); names(allData)

# next file contains titles for the variables that came from X_ group of files:
features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")
class(features); dim(features); class(features$V2)
titlesX <- as.character(features$V2)
stay <- c('subject_id', 'activity') #this vector contains names of first two variables which I
# don't want to get changed. So I'll put them in a vector and append to them vector with names for 
# the remaining 561 variables and create fullNames vector which has names of all variables
fullNames <- append(stay, titlesX)
colnames(allData) <- fullNames
names(allData)

# this next step is importing file that has labels for the type of activity. So far the 
# activity variable is an integer variable and activities are coded with an integer
activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"")
dim(activity_labels)
act_labels <- as.character(activity_labels$V2)
str(allData$activity)
allData$activity <- as.factor(allData$activity)
levels(allData$activity) <- act_labels
str(allData$subject_id)
allData$subject_id <- as.factor(allData$subject_id) # now subject_id variable has 30 levels, same 
# as the number of all participants in the experiment.

varListMean <- grep('mean', names(allData), ignore.case = TRUE)
varListStd <- grep('std', names(allData), ignore.case = TRUE)
variables <- c(varListMean, varListStd)
variables <- sort(variables)
summary(allData$subject_id)
summary(allData$activity[allData$subject_id == '1'])
# from last two summary outputs it is necessary to break the data first by subject_id, and 
# then by activity: each subjects has certain number of measurements for each of the 
# six activities
shrunkenData <- allData[,1:2]   shrunkenData <- allData[,1:2]

for(i in variables){

        shrunkenData <- cbind(shrunkenData, allData[i])
    }
    shrunkenData
dim(shrunkenData)  # 88 variables with 10299 observations
subjects <- as.integer(levels(shrunkenData$subject_id))
container <- list()
for (i in subjects){
    container<- append(container, paste('DF', i, sep = ""))
    container
}
container <- unlist(container)
container <- as.factor(container)
container_data <- list()
Cleaned <- data.frame()
coll <- rep(1,88)
Cleaned <- rbind(Cleaned, coll) #this row is added to prime the dataframe
names(Cleaned) <- names(shrunkenData)
for(element in subjects){
    dFrame <- shrunkenData[shrunkenData$subject_id == as.character(i),]
    for(label in act_labels){
        tempF <- dFrame[dFrame$activity == label,]
        tempF <- tempF[,-c(1,2)]
        per_activity <- round(apply(tempF, 2, mean, na.rm = TRUE),9) #a numeric vector
        categorical <- c(element, label)
        rowNew <- c(categorical, per_activity)
        Cleaned <- rbind(Cleaned, rowNew) 
    }
    invisible(Cleaned)
}
    
Cleaned <- Cleaned[-1,] #row 1 that was created only to adjust the dataframe is removed
exp <- Cleaned #after removing row 1, the rows start from 2 on, and to correct that I'll
#turn Cleaned data frame to list and back from list to data frame. Now the rows won't start with 2.
exp <- as.list(exp)
expPart2 <- as.data.frame(exp)
Cleaned2<- expPart2
#for now all variables are factor variables. Variables that are by nature numerical it is 
#necessary to change from factor to numerical over character:
for(iter in (3:88)){
    temp <- Cleaned2[,iter]
    temp <- as.character(temp)
    tempN <- as.numeric(temp)
    Cleaned2[,iter] <- tempN
    invisible(Cleaned2)
}
Cleaned <- Cleaned2
write.table(Cleaned, file = "tidyPhoneData.txt",sep = " ", col.names = TRUE)

tidyPhoneData <- read.table("~/tidyPhoneData.txt", header=TRUE, quote="\"")
