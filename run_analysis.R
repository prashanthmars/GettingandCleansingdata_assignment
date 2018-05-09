
### Start of Assignment

rm(list = ls(all = TRUE))

library(data.table)
library(dplyr)

### Read files
YTest <- read.table("./test/y_test.txt")
XTest <- read.table("./test/X_test.txt")
SubjectTest <- read.table("./test/subject_test.txt")
YTrain <- read.table("./train/y_train.txt")
XTrain <- read.table("./train/X_train.txt")
SubjectTrain <- read.table("./train/subject_train.txt")
Features <- read.table("./features.txt")

####Explore the data
str(YTest)
str(XTest)
str(YTrain)
str(XTrain)
str(Features)

head(YTrain)

colnames(XTrain)<-Features[,2]
colnames(XTest)<-Features[,2]

XTrain$activities <- YTrain[, 1]
XTrain$participants <- SubjectTrain[, 1]
XTest$activities <- YTest[, 1]
XTest$participants <- SubjectTest[, 1]


#1. Merges the training and the test sets to create one data set.
Masterdata <- rbind(XTrain, XTest)
str(Masterdata)

#2. Extracts only the measurements on the mean and standard deviation for each measurement
meancols<-grepl("mean",names(Masterdata),ignore.case = TRUE)
names(Masterdata)[meancols]
#Note: meandata contains the master data subset of columns that contains means
meandata<-Masterdata[,meancols]

sdcols<-grepl("std",names(Masterdata),ignore.case = TRUE)
names(Masterdata)[sdcols]
#sddata contains the master data subset of columns that contains sd
sddata<-Masterdata[,sdcols]

#3. Uses descriptive activity names to name the activities in the data set

unique(Masterdata$activities)
Masterdata$activities[Masterdata$activities == 1] <- "Walking"
Masterdata$activities[Masterdata$activities == 2] <- "Walking Upstairs"
Masterdata$activities[Masterdata$activities == 3] <- "Walking Downstairs"
Masterdata$activities[Masterdata$activities == 4] <- "Sitting"
Masterdata$activities[Masterdata$activities == 5] <- "Standing"
Masterdata$activities[Masterdata$activities == 6] <- "Laying"
Masterdata$activities <- as.factor(Masterdata$activities)
table(Masterdata$activities)


#4. Appropriately labels the data set with descriptive variable names
names(Masterdata)

names(Masterdata) <- gsub("Acc", "Accelerator", names(Masterdata))
names(Masterdata) <- gsub("Mag", "Magnitude", names(Masterdata))
names(Masterdata) <- gsub("Gyro", "Gyroscope", names(Masterdata))
names(Masterdata) <- gsub("^t", "time", names(Masterdata))
names(Masterdata) <- gsub("^f", "frequency", names(Masterdata))

Masterdata$participants<-as.character(Masterdata$participants)

for(i in unique(Masterdata$participants)){
  Masterdata$participants[Masterdata$participants == i]<-paste("Participant",i)
  print(i)
}
Masterdata$participants <- as.factor(Masterdata$participants)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Masterdatatable <- data.table(Masterdata)
ncol(Masterdatatable)
FinalTidyData <- Masterdatatable[, lapply(.SD,mean,na.rm=TRUE), by = 'participants,activities']
FinalTidyData

# Submission

write.table(FinalTidyData,"FinalTidyData.txt",row.names = FALSE) 

### End of Assignment
