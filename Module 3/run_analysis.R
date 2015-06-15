###
# Course Assignment 1 : Getting & Cleaning Data
# Author : smjb
# Dependencies : dplyr
###

###
# Based on the data from collected from accelerometer in Samsung Galaxy S
# as described in 
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# downloadable from 
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# we will merge the training and test data set and provide the mean of each measurements based  
# on different activities and test subject.
# The script will 
#     * verify the existence of all files
#     * verify the number of rows in each file within the same group (test / train) to ensure 
#       consistency across all data set
#     * load the data and merge them to become one tidy data set, replacing activity index 
#       into descriptive activity
#     * extract all column related to mean and std deviation
#     * calculate the mean of each selected column group by activity and test subject
#
# This script must be placed and run at the root directory of the dataset, ie. in the folder where 
# "train" and "test" subdirectory are located
# 
### 

message("Checking library dependencies")
dplyr_exists <- suppressWarnings(require(dplyr))

if(!dplyr_exists) {
    stop("package dplyr required. Please install via install.packages(\"dplyr\") first")
}

# setting the path as variable
path_x_train <- file.path("train", "X_train.txt")
path_y_train <- file.path("train", "y_train.txt")

path_x_test <- file.path("test", "X_test.txt")
path_y_test <- file.path("test", "y_test.txt")

path_subject_train <- file.path("train", "subject_train.txt")
path_subject_test <- file.path("test", "subject_test.txt")


path_x_combined <- file.path("x_combined.txt")
path_y_combined <- file.path("y_combined.txt")

path_features <- file.path("features.txt")
path_activity <- file.path("activity_labels.txt")

path_output_mean <- file.path("mean_output.txt")

# verify file availabilities 

if (!file.exists(path_x_test)) {
    msg <- paste("File", path_x_test, "not found !")
    stop(msg)    
} 

if (!file.exists(path_x_train)) {
    msg <- paste("File", path_x_train, "not found !")
    stop(msg)    
} 

if (!file.exists(path_y_test)) {
    msg <- paste("File", path_y_test, "not found !")
    stop(msg)    
} 

if (!file.exists(path_y_train)) {
    msg <- paste("File", path_y_train, "not found !")
    stop(msg)    
} 

if (!file.exists(path_subject_train)) {
    msg <- paste("File", path_subject_train, "not found !")
    stop(msg)    
} 

if (!file.exists(path_subject_test)) {
    msg <- paste("File", path_subject_test, "not found !")
    stop(msg)    
} 

if (!file.exists(path_features)) {
    msg <- paste("File", path_features, "not found !")
    stop(msg)    
} 

if (!file.exists(path_activity)) {
    msg <- paste("File", path_activity, "not found !")
    stop(msg)    
} 

## start loading data

# load measurement names from feature files. We will use this as the column names for the dataset
features <- read.table(path_features, header=FALSE, colClasses = c(integer(), character()),as.is = c(TRUE, TRUE))
# replace special characters with "empty" or "_" to allow column name manipulation in R
features$V2 <- gsub("[)()]", "", features$V2)
features$V2 <- gsub("[,-]", "_", features$V2)

# make.names is not used because it will return names with two successive "dots" in certain feature
## features$V2 <- make.names(features$V2)

# loading dataset
xtrain <- read.table(path_x_train, header = FALSE)
xtest <- read.table(path_x_test, header=FALSE)
ytrain <- read.table(path_y_train, header = FALSE)
ytest <- read.table(path_y_test, header=FALSE)

# loading the subject index that generated the measurement. We assume that the row in this file correspond 
# to the same row in the other files
subject_train <- read.table(path_subject_train, header = FALSE, colClasses=factor())
subject_test <- read.table(path_subject_test, header=FALSE, colClasses=factor())

# loading the activity index that generated the measurement. We assume that the row in this file correspond 
# to the same row in the other files
activity_labels <- read.table(path_activity, header=FALSE, colClasses = factor())

message("All data file loaded.")

# verify data integrity via dimension comparison

#number of rows must be the same within different files of the same group (test/train)

dim_x_train <- dim(xtrain)[1]
dim_y_train <- dim(ytrain)[1]
dim_subject_train <- dim(subject_train)[1]

if (dim_x_train != dim_y_train || dim_x_train != dim_subject_train) {
    msg <- paste("Training files do not have same rows (X | Y | Subject) =", dim_x_train, "|", dim_y_train, "|", dim_subject_train, ")")
    stop(msg)
}

dim_x_test <- dim(xtest)[1]
dim_y_test <- dim(ytest)[1]
dim_subject_test <- dim(subject_test)[1]

if (dim_x_test != dim_y_test || dim_x_test != dim_subject_test) {
    msg <- paste("Test files do not have same rows (X | Y | Subject) =", dim_x_test, "|", dim_y_test, "|", dim_subject_test, ")")
    stop(msg)
}

# the number of column in the Xfiles must be equal to the number of measurement described in the feature.txt

dim_x_test <- dim(xtest)[2]
dim_x_train <- dim(xtrain)[2]
dim_features <- dim(features)[1]

if (dim_x_test != dim_x_train || dim_x_test != dim_features) {
    msg <- paste("Test files do not have same columns (X | Y | features' ) =", dim_x_test, "|", dim_y_test, "|", dim_features, ")")
    stop(msg)
}

message("Data files table dimension verified and consistent. Combining all data ...")

# we will now combine all dataset. We shall append TRAIN data after TEST data and 
# must be made consistent across board

xdata <- rbind(xtest, xtrain)
ydata <- rbind(ytest, ytrain)
subject <- rbind(subject_test, subject_train)

#apply feature.txt measurement description as column names for data
colnames(xdata) <- features$V2
colnames(ydata) <- "Labels"
colnames(subject) <- "Subject"
# change data class to factor
subject$Subject <- as.factor(subject$Subject)
ydata$Labels <- as.factor(ydata$Labels)

# replace Activity Labels with Activity Description
Xact <- merge(ydata, activity_labels, by.x="Labels", by.y="V1")
colnames(Xact) <- c("LabelIndex", "LabelDesc")
ActivityDesc <- as.factor(Xact$LabelDesc)

#combine all dataset horizontally to create wide tidy dataset
fulldata <- cbind(subject, ActivityDesc, xdata)

# remove temporary variables for memory management
rm(list = c("xtrain", "xtest", "ytrain", "ytest", "subject_train", 
            "subject_test", "xdata", "ydata", "subject", "Xact", "ActivityDesc"))
message("Staging data removed for memory management.")

#select column with mean and std only
#load library
library(dplyr)

# we only want mean and std deviaton values. We can select all measurement names containing the word
# mean or std. This will produce a list of column with those keywords but we need to filter out certain 
# measurement use mean as input such as angle(xyx, Xmean) or frequencyMean. 
# we use intersect to achieve this

mean.and.std <- intersect(grep("mean|std", features$V2, ignore.case = TRUE) , 
                          grep("freq|angle", features$V2, ignore.case = TRUE, invert=TRUE))
# the column extracted in mean.and.std are indexed from 1 since it is purely measurement column. 
# Our full dataset has two extra column in the begining, therefore the measurement column needs 
# to be shifted to the right by 2 index
subsetData <- tbl_df(fulldata[, c(1, 2, mean.and.std+2)])

# group by Activity Desc and Subject using dplyr library
byActivity_Subject = group_by(subsetData, ActivityDesc, Subject)

# calculate each column value by summarise_each pregrouped
tidymeandata<-summarise_each(byActivity_Subject, funs(mean))


write.table(tidymeandata, path_output_mean, row.name = FALSE)

