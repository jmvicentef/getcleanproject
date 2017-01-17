### Create one R script called run_analysis.R that does the following.

## Merges the training and the test sets to create one data set. 

# first we clean global environment

rm(list=ls())

# download data and unzip it

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile = "./data/data.zip", method = "curl")
unzip("./data/data.zip", exdir = "./data/")

# going to downloaded dir

setwd("./data/UCI HAR Dataset/")

# reading in test and train data

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Creation 'x', 'y' and 'subject' data sets

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

## Extracts only the measurements on the mean and standard deviation for each measurement.

# we read in the features

features <- read.table("features.txt")

# Using regexp to grep only when mean() or std() are in the feat name
mean_sd_feat <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_sd_feat]

# correct the column names
names(x_data) <- features[mean_sd_feat, 2]


## Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("activity_labels.txt")

# Updating values with activity name
y_data[, 1] <- activity_labels[y_data[, 1], 2]

# Correcting name of columns
names(y_data) <- "activity"


## Appropriately labels the data set with descriptive variable names.

# Correcting name of columns

names(subject_data) <- "subject"

# Cbinding all the data in one data set

all_data <- cbind(x_data, y_data, subject_data)

## From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# we do this con ddply

library(plyr)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)