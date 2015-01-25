#
# This R function is used to generate the activity and subject based mean values of 
# the 66 measurements on the mean and standard deviation of each measures from the 
# dataset of the experiements on human recognition using smartphones.
#
#  Here are the steps to use this function:
#  1. Create folder c:\course\Data Cleaning\Data Science\Project
#  2. Download the zipped dataset from the link:
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#  3. Unzip the downloaded data into the following folder:
#     C:/Course/Data Cleaning/Data Science/Project/UCI HAR Dataset
#  4. call this function
#
#  The function will return a list with two data frames
#   1. final1: this is a extraction of the measurements on the mean and standard deviation of each
#      measures from the experiement dataset. The variable names are the descriptive labels of the
#      measurements
#   2. final2: this contains the subject and activity based mean values of the measurements on
#      the mean and standard deviation of each measures
#
#   The function will also write final2 to tidydata.txt file under the working directory, i.e., C:/Course/Data Cleaning/Data Science/Project
#

run_analysis <- function()
{ 
    library(dplyr)
    library(tidyr)
    library(data.table)
    library(plyr)
    library(reshape2)
    
    # set working directory 
    
    setwd("C:/Course/Data Cleaning/Data Science/Project/UCI HAR Dataset")
    
    
    # Function to Read subjects
    
    read_subject <- function (directory) {
      subject_file <- paste(directory, "/subject_", directory, ".txt", sep="" )
      x_file <- paste(directory, "/x_", directory, ".txt", sep="" )
      y_file <- paste(directory, "/y_", directory, ".txt", sep="" )
      
      subject <- read.table(subject_file)
      x <- read.table(x_file)
      y <- read.table(y_file)
      return (list(subject=subject, x=x, y=y))
    }
    
    # Read Features
    
    features <- read.table("features.txt")
    dim(features)
    names(features) <- c("featureId", "feature")
    
    # Read activity labels
    
    activity_labels <- read.table("activity_labels.txt")
    names(activity_labels) <- c("activityId", "activity")
    dim(activity_labels)
    
    # Read test subject
    
    subject <- read_subject("test")
    subject_test <- subject$subject
    x_test <- subject$x
    y_test <- subject$y

    
    # Read training subject
    
    subject <- read_subject("train")
    subject_train <- subject$subject
    x_train <- subject$x
    y_train <- subject$y
  
    
    # Function to bind data with subject and activity
    
    bind_data <- function(data, subject, activity) {
      data ["subjectId"] <- subject
      data ["activityId"] <- activity
      return (data)
    }
    
    # bind data with subject and activity
  
    data_train <- bind_data(x_train, subject_train, y_train)
    data_test <- bind_data(x_test, subject_test, y_test)
    

    # 1.Merges the training and the test sets to create one data set.
    
    data <- rbind(data_test, data_train)
    names(data)
    
    # 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
    
    # get the column names with mean or std in the names
    
    name_pattern <- c("mean", "std")
    feature_std_mean <- rbind(features[grep("mean\\(\\)", features$feature),], features[grep("std\\(\\)", features$feature),] ) 
    feature_indices <- feature_std_mean$featureId
    
    # Keep "activityId", "subjectId" and all columns with "mean" or "std" in them
    
    colNames <- c("activityId", "subjectId", paste("V", feature_indices,sep=""))
    data_std_mean <- data[,colNames]
    
    head(data_std_mean)
    
    str(data_std_mean)
    
    # 3.Uses descriptive activity names to name the activities in the data set
    
    final1 <- merge(activity_labels, data_std_mean, by.x="activityId", by.y="activityId")
    final1$activityId <- NULL
    
    #4.Appropriately labels the data set with descriptive variable names
    
    feature_std_mean["oldName"] <- paste("V", feature_std_mean$featureId, sep="")
    feature_std_mean["newName"] <- feature_std_mean$feature  
    setnames(final1, old=feature_std_mean$oldName, new=as.character(feature_std_mean$newName))
    head(final1, 10)
    
    #5.From the data set in step 4, creates a second, independent tidy data set with the average 
    # of each variable for each activity and each subject.
  
  
    final1$subjectId <- as.factor(final1$subjectId)
    
    # Pivot the final1
    data_pivot <- melt(final1, id.vars = c("activity", "subjectId"))  
    
    # Calculate the mean
    data_mean <- ddply(data_pivot, .(subjectId, activity, variable), summarise, mean=mean(value))
    head(data_mean,10)
       
    str(data_mean)
    
    # Un-pivot to get the final mean data
    
    final2 <- dcast(data_mean, subjectId + activity ~ variable, value.var="mean")
    write.table(final2, file="tidydata.txt", row.names=FALSE)
    
    return (list(final=final1, mean=final2))
}


