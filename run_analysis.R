#Getting and Cleaning Data - Course Project

# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#origDir=getwd()
#setwd("~/Coursera/Getting and Cleaning Data/CourseProject/UCI HAR Dataset/")

#Training Data
y_train <- read.table("./train/y_train.txt", quote="\"")
X_train <- read.table("./train/X_train.txt", quote="\"")
subject_train <- read.table("./train/subject_train.txt", quote="\"")


#Test Data
y_test <- read.table("./test/y_test.txt", quote="\"")
X_test <- read.table("./test/X_test.txt", quote="\"")
subject_test <- read.table("./test/subject_test.txt", quote="\"")

activity_labels <- read.table("activity_labels.txt", quote="\"")
features <- read.table("features.txt", quote="\"")

#Standard deviation features:
stddev_features=features$V1[grep("std",features$V2)]
stddev_names=as.character(features$V2[grep("std",features$V2)])

#Mean features:
mean_features=features$V1[grep("mean",features$V2)]
mean_names=as.character(features$V2[grep("mean",features$V2)])


#All features to get
features_to_get=c(stddev_features, mean_features)
cols_to_get=paste("V",features_to_get, sep="")
colNames=c(stddev_names, mean_names)

X_train_subset=subset(X_train, , select=cols_to_get)
names(X_train_subset)=colNames

X_test_subset=subset(X_test, , select=cols_to_get)
names(X_test_subset)=colNames

# #Add factor to ID observations as training data
# X_train_subset$testtrain="train"
# X_test_subset$testtrain="test"

#Map the activity names and add factor
activityNames=sapply(y_train, function(x) {
    activity_labels$V2[y_train$V1]})

X_train_subset$activity=activityNames[,1]

activityNames=sapply(y_test, function(x) {
  activity_labels$V2[y_test$V1]})

X_test_subset$activity=activityNames[,1]

#Add the subject Ids
X_train_subset$subjectId=subject_train$V1
X_test_subset$subjectId=subject_test$V1

#Combined training and test data into one dataset
combinedDataset= merge(X_train_subset,X_test_subset,all=TRUE)

#Clean up - removing all data but the combinedDataset
removelist=ls()
#running again to capture removelist!
removelist=ls()
removelist=removelist[removelist != "combinedDataset"]
rm(list=removelist)

#Get Averages for each subject
library(plyr)
results=ddply(combinedDataset,.(subjectId,activity),numcolwise(mean))

#setwd(origDir)
