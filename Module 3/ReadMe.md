# Course Assignment 1 : Getting & Cleaning Data

------------

 Based on the data from collected from accelerometer in Samsung Galaxy S
 as described in 
     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 downloadable from 
     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 we will merge the training and test data set and provide the mean of each measurements based  
 on different activities and test subject.
 The script will 
     * verify the existence of all files
     * verify the number of rows in each file within the same group (test / train) to ensure 
       consistency across all data set
     * load the data and merge them to become one tidy data set, replacing activity index 
       into descriptive activity
     * extract all column related to mean and std deviation
     * calculate the mean of each selected column group by activity and test subject

 This script must be placed and run at the root directory of the dataset, ie. in the folder where 
 "train" and "test" subdirectory are located
 
 
