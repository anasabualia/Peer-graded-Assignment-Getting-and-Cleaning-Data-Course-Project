#Downloading and unzipping dataset

if(!file.exists("./data")){dir.create("./data")}
#Here are the data for the project:
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/HumanActivityDataset.zip")
# Unzip the dataSet to /data directory
unzip(zipfile="./data/HumanActivityDataset.zip",exdir="./data")

#Load the required libraries
library("dplyr")

#Step 1: Merges the training and the test sets to create one data set:
# Reading files (Training & Test)

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "activityCode")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",col.names = "subject")

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "activityCode")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",col.names = "subject")

features <- read.table('./data/UCI HAR Dataset/features.txt', col.names = c("n","functions")) #Represents the Headers
activityLabels <- read.table('./data/UCI HAR Dataset/activity_labels.txt',col.names = c("activityCode", "activity")) #Lables Description

#Add Column name to the main datasets
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2] 

#Merge All data
full_train <- cbind(y_train, subject_train, x_train)
full_test <- cbind(y_test, subject_test, x_test)
TargetDataSet <- rbind(full_train, full_test)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement:
MeanAndStdDataSet <- select(TargetDataSet,activityCode,subject,contains('mean()', ignore.case = TRUE), contains('std()', ignore.case = TRUE))

#Step 3: Uses descriptive activity names to name the activities in the data set:
setWithActivityNames <- merge(MeanAndStdDataSet, activityLabels,by='activityCode', all.x=TRUE)
#Step 4: Appropriately labels the data set with descriptive variable names:
#some renaming already done above.
names(setWithActivityNames)<-gsub("^t", "Time", names(setWithActivityNames))
names(setWithActivityNames)<-gsub("^f", "Frequency", names(setWithActivityNames))
#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
FinalData <- setWithActivityNames %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "./data/FinalData.txt", row.name=FALSE)




