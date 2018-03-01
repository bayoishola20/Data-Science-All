#Data download
getwd() #get current working directory
setwd("./Documents/R_works") #setting desired working directory
destfile <- "Dataset.zip" #setting destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile) #file download

#Unzip Dataset
unzip("Dataset.zip")

#Load required packages
library(dplyr) #loading -- for data manipulation
library(data.table) #loading -- Data.frame extension
install.packages("tidyr") #for ease in tidying data
library(tidyr)

#set 

#Reading needed files

#Subject files

subjectTrainingData <- tbl_df(read.table(file.path("./UCI HAR Dataset", "train", "subject_train.txt")))
subjectTestData  <- tbl_df(read.table(file.path("./UCI HAR Dataset", "test" , "subject_test.txt" )))

#Activity files
activityTrainingData <- tbl_df(read.table(file.path("./UCI HAR Dataset", "train", "y_train.txt")))
activityTestData  <- tbl_df(read.table(file.path("./UCI HAR Dataset", "test" , "y_test.txt" )))

#Data files.
dataTrain <- tbl_df(read.table(file.path("./UCI HAR Dataset", "train", "X_train.txt" )))
dataTest  <- tbl_df(read.table(file.path("./UCI HAR Dataset", "test" , "X_test.txt" )))


#MERGING BOTH TRAINING AND TEST DATA SETS..

allSubjectData <- rbind(subjectTrainingData, subjectTestData)
setnames(allSubjectData, "V1", "all_subject")

allActivityData <- rbind(activityTrainingData, activityTestData)
setnames(allActivityData, "V1", "all_activity")

allData <- rbind(dataTrain, dataTest)
setnames(allData, "V1", "all_Data")

#naming of variables by features.
features <- tbl_df(read.table(file.path("./UCI HAR Dataset", "features.txt")))
setnames(features, names(features), c("featureID", "featureName"))
colnames(allData) <- features$featureName

# for activity labels
activityLabels <- tbl_df(read.table(file.path("./UCI HAR Dataset", "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityID","activityName"))

#final merge along columns
alldataSubject<- cbind(allSubjectData, allActivityData)
dataTable <- cbind(alldataSubject, allData)

#EXTRACTING ONLY THE MEASUREMENTS ON THE MEAN AND STD FOR EACH MEASUREMENT.
featuresMeanSTD <- grep("mean\\(\\)|std\\(\\)",features$featureName,value=TRUE)
featuresMeanSTD <- union(c("all_subject","all_activity"), featuresMeanSTD)
allData<- subset(dataTable,select=featuresMeanSTD)

#DESCRIPTIVE ACTIVITY NAMING OF ACTIVITIES IN DATA SET
##entering name of activity into dataTable
dataTable <- merge(activityLabels, dataTable)

##dataTable with variable means sorted by subject and Activity
dataAGG<- aggregate(. ~ all_subject - activityName, data = dataTable, mean) 
dataTable <- tbl_df(arrange(dataAGG,all_subject,activityName))

#LABELLING OF DATA WITH DESCRIPTIVE NAMES

names(dataTable)<-gsub("std()", "SD", names(dataTable))
names(dataTable)<-gsub("mean()", "MEAN", names(dataTable))
names(dataTable)<-gsub("^t", "time", names(dataTable))
names(dataTable)<-gsub("^f", "frequency", names(dataTable))
names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
names(dataTable)<-gsub("Gyro", "Gyroscope", names(dataTable))
names(dataTable)<-gsub("Mag", "Magnitude", names(dataTable))
names(dataTable)<-gsub("BodyBody", "Body", names(dataTable))

head(str(dataTable),6) #after labelling

#CREATION OF INDEPENDENT SECOND TIDY DATA SET WITH AVERAGE OF EACH VARIABLE

write.table(dataTable, "tidy_data.txt", row.name=FALSE)
