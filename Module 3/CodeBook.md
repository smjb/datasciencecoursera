# CodeBook for Getting and Cleaning Data Course Project


----------


## Background
The *run_analysis.R* script will run on the data from collected from accelerometer in Samsung Galaxy S as described in 
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
downloadable from 
     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**This document must be read together with the original data set description to understand the data.**


----------


## Preprocessing
The dataset contains multiple files and two sub folders, namely _train_ and _test_.
In each subfolders, there are 3 data files (*subject_test*, *X_[file]* and *y_[file]*) and another subfolder called _Inertial Signal_. 
We assume that the three files are joined  by its row number (It is supported based on the identitical number of rows in these files)

The script will ignore the data in _Inertial_Signal_.

### X_file
This dataset contains the some estimations of the filtered measurements (in time and frequency for each Cartesian axis)from the embedded accelerometer and gyroscope. 
Each row represent the estimations of each Subject doing a Specific Activity during an interval. 
There are 561 different estimations in each observation

### y_file
This dataset contains the activity code during the measurement made in X_file

### subject_test
This dataset contains the Subject ID during the measurement made in X_file

The data from these 3 files are merged together (wide format) using **cbind**
The wide test and train data is then combined using **rbind**

### Naming the rows
#### Estimation names
The script will load features.txt to get the estimation name and then uses it to define the column in the full wide dataset.
However, the estimation names in features.txt contains characters difficult to manipulate in R. The script will strip all these characters and replace some of them with "_". 
The replacement is purely arbitrary as it depends to the script writer self naming convention.
In this script, all parenthesis characters ( "(" and ")" )are stripped while comma and hyphen (",", "-") are replaced with "_".
This is achieved by 
> features$V2 <- gsub("[)(]", "", features$V2)
> features$V2 <- gsub("[,-]", "_", features$V2)

The full column names after manipulation can be found at the end of this document 

####Activity description
The file *activity_labels.txt* contains the Activity Code and its description. The script will load *activity_labels.txt* and use merge function to replace the activity code column in the full dataset (Column 2) with its description.

----------


## Selecting rows related to mean and standard deviation
The assignment requires subsetting of mean and standard deviation columns. 
As per the original data set description, the script will seach for the keywords "mean" and "std" within the estimation names. 
However there are few estimation names that contains the same search words but does not infer to average of measurement. 
The estimations with names like "meanFreq" and "angle" must not be selected for further analysis.
The intersect between [ *column with **mean** or **std** in name* ] and [ *column without **freq** and **angle** in name* ] will select the columns required for the assignment

## Final Output
The final output is a table of 35 observations and 68 measurements, where the average value of each mean.and.std subset measurement are generated and 
they are grouped by the Activity made and the Subject ID


----------
 
## Data 


# R-friendly Estimation names 
```
> tBodyAcc_mean_X
> tBodyAcc_mean_Y
> tBodyAcc_mean_Z
> tBodyAcc_std_X
> tBodyAcc_std_Y
> tBodyAcc_std_Z
> tBodyAcc_mad_X
> tBodyAcc_mad_Y
> tBodyAcc_mad_Z
> tBodyAcc_max_X
> tBodyAcc_max_Y
> tBodyAcc_max_Z
> tBodyAcc_min_X
> tBodyAcc_min_Y
> tBodyAcc_min_Z
> tBodyAcc_sma
> tBodyAcc_energy_X
> tBodyAcc_energy_Y
> tBodyAcc_energy_Z
> tBodyAcc_iqr_X
> tBodyAcc_iqr_Y
> tBodyAcc_iqr_Z
> tBodyAcc_entropy_X
> tBodyAcc_entropy_Y
> tBodyAcc_entropy_Z
> tBodyAcc_arCoeff_X_1
> tBodyAcc_arCoeff_X_2
> tBodyAcc_arCoeff_X_3
> tBodyAcc_arCoeff_X_4
> tBodyAcc_arCoeff_Y_1
> tBodyAcc_arCoeff_Y_2
> tBodyAcc_arCoeff_Y_3
> tBodyAcc_arCoeff_Y_4
> tBodyAcc_arCoeff_Z_1
> tBodyAcc_arCoeff_Z_2
> tBodyAcc_arCoeff_Z_3
> tBodyAcc_arCoeff_Z_4
> tBodyAcc_correlation_X_Y
> tBodyAcc_correlation_X_Z
> tBodyAcc_correlation_Y_Z
> tGravityAcc_mean_X
> tGravityAcc_mean_Y
> tGravityAcc_mean_Z
> tGravityAcc_std_X
> tGravityAcc_std_Y
> tGravityAcc_std_Z
> tGravityAcc_mad_X
> tGravityAcc_mad_Y
> tGravityAcc_mad_Z
> tGravityAcc_max_X
> tGravityAcc_max_Y
> tGravityAcc_max_Z
> tGravityAcc_min_X
> tGravityAcc_min_Y
> tGravityAcc_min_Z
> tGravityAcc_sma
> tGravityAcc_energy_X
> tGravityAcc_energy_Y
> tGravityAcc_energy_Z
> tGravityAcc_iqr_X
> tGravityAcc_iqr_Y
> tGravityAcc_iqr_Z
> tGravityAcc_entropy_X
> tGravityAcc_entropy_Y
> tGravityAcc_entropy_Z
> tGravityAcc_arCoeff_X_1
> tGravityAcc_arCoeff_X_2
> tGravityAcc_arCoeff_X_3
> tGravityAcc_arCoeff_X_4
> tGravityAcc_arCoeff_Y_1
> tGravityAcc_arCoeff_Y_2
> tGravityAcc_arCoeff_Y_3
> tGravityAcc_arCoeff_Y_4
> tGravityAcc_arCoeff_Z_1
> tGravityAcc_arCoeff_Z_2
> tGravityAcc_arCoeff_Z_3
> tGravityAcc_arCoeff_Z_4
> tGravityAcc_correlation_X_Y
> tGravityAcc_correlation_X_Z
> tGravityAcc_correlation_Y_Z
> tBodyAccJerk_mean_X
> tBodyAccJerk_mean_Y
> tBodyAccJerk_mean_Z
> tBodyAccJerk_std_X
> tBodyAccJerk_std_Y
> tBodyAccJerk_std_Z
> tBodyAccJerk_mad_X
> tBodyAccJerk_mad_Y
> tBodyAccJerk_mad_Z
> tBodyAccJerk_max_X
> tBodyAccJerk_max_Y
> tBodyAccJerk_max_Z
> tBodyAccJerk_min_X
> tBodyAccJerk_min_Y
> tBodyAccJerk_min_Z
> tBodyAccJerk_sma
> tBodyAccJerk_energy_X
> tBodyAccJerk_energy_Y
> tBodyAccJerk_energy_Z
> tBodyAccJerk_iqr_X
> tBodyAccJerk_iqr_Y
> tBodyAccJerk_iqr_Z
> tBodyAccJerk_entropy_X
> tBodyAccJerk_entropy_Y
> tBodyAccJerk_entropy_Z
> tBodyAccJerk_arCoeff_X_1
> tBodyAccJerk_arCoeff_X_2
> tBodyAccJerk_arCoeff_X_3
> tBodyAccJerk_arCoeff_X_4
> tBodyAccJerk_arCoeff_Y_1
> tBodyAccJerk_arCoeff_Y_2
> tBodyAccJerk_arCoeff_Y_3
> tBodyAccJerk_arCoeff_Y_4
> tBodyAccJerk_arCoeff_Z_1
> tBodyAccJerk_arCoeff_Z_2
> tBodyAccJerk_arCoeff_Z_3
> tBodyAccJerk_arCoeff_Z_4
> tBodyAccJerk_correlation_X_Y
> tBodyAccJerk_correlation_X_Z
> tBodyAccJerk_correlation_Y_Z
> tBodyGyro_mean_X
> tBodyGyro_mean_Y
> tBodyGyro_mean_Z
> tBodyGyro_std_X
> tBodyGyro_std_Y
> tBodyGyro_std_Z
> tBodyGyro_mad_X
> tBodyGyro_mad_Y
> tBodyGyro_mad_Z
> tBodyGyro_max_X
> tBodyGyro_max_Y
> tBodyGyro_max_Z
> tBodyGyro_min_X
> tBodyGyro_min_Y
> tBodyGyro_min_Z
> tBodyGyro_sma
> tBodyGyro_energy_X
> tBodyGyro_energy_Y
> tBodyGyro_energy_Z
> tBodyGyro_iqr_X
> tBodyGyro_iqr_Y
> tBodyGyro_iqr_Z
> tBodyGyro_entropy_X
> tBodyGyro_entropy_Y
> tBodyGyro_entropy_Z
> tBodyGyro_arCoeff_X_1
> tBodyGyro_arCoeff_X_2
> tBodyGyro_arCoeff_X_3
> tBodyGyro_arCoeff_X_4
> tBodyGyro_arCoeff_Y_1
> tBodyGyro_arCoeff_Y_2
> tBodyGyro_arCoeff_Y_3
> tBodyGyro_arCoeff_Y_4
> tBodyGyro_arCoeff_Z_1
> tBodyGyro_arCoeff_Z_2
> tBodyGyro_arCoeff_Z_3
> tBodyGyro_arCoeff_Z_4
> tBodyGyro_correlation_X_Y
> tBodyGyro_correlation_X_Z
> tBodyGyro_correlation_Y_Z
> tBodyGyroJerk_mean_X
> tBodyGyroJerk_mean_Y
> tBodyGyroJerk_mean_Z
> tBodyGyroJerk_std_X
> tBodyGyroJerk_std_Y
> tBodyGyroJerk_std_Z
> tBodyGyroJerk_mad_X
> tBodyGyroJerk_mad_Y
> tBodyGyroJerk_mad_Z
> tBodyGyroJerk_max_X
> tBodyGyroJerk_max_Y
> tBodyGyroJerk_max_Z
> tBodyGyroJerk_min_X
> tBodyGyroJerk_min_Y
> tBodyGyroJerk_min_Z
> tBodyGyroJerk_sma
> tBodyGyroJerk_energy_X
> tBodyGyroJerk_energy_Y
> tBodyGyroJerk_energy_Z
> tBodyGyroJerk_iqr_X
> tBodyGyroJerk_iqr_Y
> tBodyGyroJerk_iqr_Z
> tBodyGyroJerk_entropy_X
> tBodyGyroJerk_entropy_Y
> tBodyGyroJerk_entropy_Z
> tBodyGyroJerk_arCoeff_X_1
> tBodyGyroJerk_arCoeff_X_2
> tBodyGyroJerk_arCoeff_X_3
> tBodyGyroJerk_arCoeff_X_4
> tBodyGyroJerk_arCoeff_Y_1
> tBodyGyroJerk_arCoeff_Y_2
> tBodyGyroJerk_arCoeff_Y_3
> tBodyGyroJerk_arCoeff_Y_4
> tBodyGyroJerk_arCoeff_Z_1
> tBodyGyroJerk_arCoeff_Z_2
> tBodyGyroJerk_arCoeff_Z_3
> tBodyGyroJerk_arCoeff_Z_4
> tBodyGyroJerk_correlation_X_Y
> tBodyGyroJerk_correlation_X_Z
> tBodyGyroJerk_correlation_Y_Z
> tBodyAccMag_mean
> tBodyAccMag_std
> tBodyAccMag_mad
> tBodyAccMag_max
> tBodyAccMag_min
> tBodyAccMag_sma
> tBodyAccMag_energy
> tBodyAccMag_iqr
> tBodyAccMag_entropy
> tBodyAccMag_arCoeff1
> tBodyAccMag_arCoeff2
> tBodyAccMag_arCoeff3
> tBodyAccMag_arCoeff4
> tGravityAccMag_mean
> tGravityAccMag_std
> tGravityAccMag_mad
> tGravityAccMag_max
> tGravityAccMag_min
> tGravityAccMag_sma
> tGravityAccMag_energy
> tGravityAccMag_iqr
> tGravityAccMag_entropy
> tGravityAccMag_arCoeff1
> tGravityAccMag_arCoeff2
> tGravityAccMag_arCoeff3
> tGravityAccMag_arCoeff4
> tBodyAccJerkMag_mean
> tBodyAccJerkMag_std
> tBodyAccJerkMag_mad
> tBodyAccJerkMag_max
> tBodyAccJerkMag_min
> tBodyAccJerkMag_sma
> tBodyAccJerkMag_energy
> tBodyAccJerkMag_iqr
> tBodyAccJerkMag_entropy
> tBodyAccJerkMag_arCoeff1
> tBodyAccJerkMag_arCoeff2
> tBodyAccJerkMag_arCoeff3
> tBodyAccJerkMag_arCoeff4
> tBodyGyroMag_mean
> tBodyGyroMag_std
> tBodyGyroMag_mad
> tBodyGyroMag_max
> tBodyGyroMag_min
> tBodyGyroMag_sma
> tBodyGyroMag_energy
> tBodyGyroMag_iqr
> tBodyGyroMag_entropy
> tBodyGyroMag_arCoeff1
> tBodyGyroMag_arCoeff2
> tBodyGyroMag_arCoeff3
> tBodyGyroMag_arCoeff4
> tBodyGyroJerkMag_mean
> tBodyGyroJerkMag_std
> tBodyGyroJerkMag_mad
> tBodyGyroJerkMag_max
> tBodyGyroJerkMag_min
> tBodyGyroJerkMag_sma
> tBodyGyroJerkMag_energy
> tBodyGyroJerkMag_iqr
> tBodyGyroJerkMag_entropy
> tBodyGyroJerkMag_arCoeff1
> tBodyGyroJerkMag_arCoeff2
> tBodyGyroJerkMag_arCoeff3
> tBodyGyroJerkMag_arCoeff4
> fBodyAcc_mean_X
> fBodyAcc_mean_Y
> fBodyAcc_mean_Z
> fBodyAcc_std_X
> fBodyAcc_std_Y
> fBodyAcc_std_Z
> fBodyAcc_mad_X
> fBodyAcc_mad_Y
> fBodyAcc_mad_Z
> fBodyAcc_max_X
> fBodyAcc_max_Y
> fBodyAcc_max_Z
> fBodyAcc_min_X
> fBodyAcc_min_Y
> fBodyAcc_min_Z
> fBodyAcc_sma
> fBodyAcc_energy_X
> fBodyAcc_energy_Y
> fBodyAcc_energy_Z
> fBodyAcc_iqr_X
> fBodyAcc_iqr_Y
> fBodyAcc_iqr_Z
> fBodyAcc_entropy_X
> fBodyAcc_entropy_Y
> fBodyAcc_entropy_Z
> fBodyAcc_maxInds_X
> fBodyAcc_maxInds_Y
> fBodyAcc_maxInds_Z
> fBodyAcc_meanFreq_X
> fBodyAcc_meanFreq_Y
> fBodyAcc_meanFreq_Z
> fBodyAcc_skewness_X
> fBodyAcc_kurtosis_X
> fBodyAcc_skewness_Y
> fBodyAcc_kurtosis_Y
> fBodyAcc_skewness_Z
> fBodyAcc_kurtosis_Z
> fBodyAcc_bandsEnergy_1_8
> fBodyAcc_bandsEnergy_9_16
> fBodyAcc_bandsEnergy_17_24
> fBodyAcc_bandsEnergy_25_32
> fBodyAcc_bandsEnergy_33_40
> fBodyAcc_bandsEnergy_41_48
> fBodyAcc_bandsEnergy_49_56
> fBodyAcc_bandsEnergy_57_64
> fBodyAcc_bandsEnergy_1_16
> fBodyAcc_bandsEnergy_17_32
> fBodyAcc_bandsEnergy_33_48
> fBodyAcc_bandsEnergy_49_64
> fBodyAcc_bandsEnergy_1_24
> fBodyAcc_bandsEnergy_25_48
> fBodyAcc_bandsEnergy_1_8
> fBodyAcc_bandsEnergy_9_16
> fBodyAcc_bandsEnergy_17_24
> fBodyAcc_bandsEnergy_25_32
> fBodyAcc_bandsEnergy_33_40
> fBodyAcc_bandsEnergy_41_48
> fBodyAcc_bandsEnergy_49_56
> fBodyAcc_bandsEnergy_57_64
> fBodyAcc_bandsEnergy_1_16
> fBodyAcc_bandsEnergy_17_32
> fBodyAcc_bandsEnergy_33_48
> fBodyAcc_bandsEnergy_49_64
> fBodyAcc_bandsEnergy_1_24
> fBodyAcc_bandsEnergy_25_48
> fBodyAcc_bandsEnergy_1_8
> fBodyAcc_bandsEnergy_9_16
> fBodyAcc_bandsEnergy_17_24
> fBodyAcc_bandsEnergy_25_32
> fBodyAcc_bandsEnergy_33_40
> fBodyAcc_bandsEnergy_41_48
> fBodyAcc_bandsEnergy_49_56
> fBodyAcc_bandsEnergy_57_64
> fBodyAcc_bandsEnergy_1_16
> fBodyAcc_bandsEnergy_17_32
> fBodyAcc_bandsEnergy_33_48
> fBodyAcc_bandsEnergy_49_64
> fBodyAcc_bandsEnergy_1_24
> fBodyAcc_bandsEnergy_25_48
> fBodyAccJerk_mean_X
> fBodyAccJerk_mean_Y
> fBodyAccJerk_mean_Z
> fBodyAccJerk_std_X
> fBodyAccJerk_std_Y
> fBodyAccJerk_std_Z
> fBodyAccJerk_mad_X
> fBodyAccJerk_mad_Y
> fBodyAccJerk_mad_Z
> fBodyAccJerk_max_X
> fBodyAccJerk_max_Y
> fBodyAccJerk_max_Z
> fBodyAccJerk_min_X
> fBodyAccJerk_min_Y
> fBodyAccJerk_min_Z
> fBodyAccJerk_sma
> fBodyAccJerk_energy_X
> fBodyAccJerk_energy_Y
> fBodyAccJerk_energy_Z
> fBodyAccJerk_iqr_X
> fBodyAccJerk_iqr_Y
> fBodyAccJerk_iqr_Z
> fBodyAccJerk_entropy_X
> fBodyAccJerk_entropy_Y
> fBodyAccJerk_entropy_Z
> fBodyAccJerk_maxInds_X
> fBodyAccJerk_maxInds_Y
> fBodyAccJerk_maxInds_Z
> fBodyAccJerk_meanFreq_X
> fBodyAccJerk_meanFreq_Y
> fBodyAccJerk_meanFreq_Z
> fBodyAccJerk_skewness_X
> fBodyAccJerk_kurtosis_X
> fBodyAccJerk_skewness_Y
> fBodyAccJerk_kurtosis_Y
> fBodyAccJerk_skewness_Z
> fBodyAccJerk_kurtosis_Z
> fBodyAccJerk_bandsEnergy_1_8
> fBodyAccJerk_bandsEnergy_9_16
> fBodyAccJerk_bandsEnergy_17_24
> fBodyAccJerk_bandsEnergy_25_32
> fBodyAccJerk_bandsEnergy_33_40
> fBodyAccJerk_bandsEnergy_41_48
> fBodyAccJerk_bandsEnergy_49_56
> fBodyAccJerk_bandsEnergy_57_64
> fBodyAccJerk_bandsEnergy_1_16
> fBodyAccJerk_bandsEnergy_17_32
> fBodyAccJerk_bandsEnergy_33_48
> fBodyAccJerk_bandsEnergy_49_64
> fBodyAccJerk_bandsEnergy_1_24
> fBodyAccJerk_bandsEnergy_25_48
> fBodyAccJerk_bandsEnergy_1_8
> fBodyAccJerk_bandsEnergy_9_16
> fBodyAccJerk_bandsEnergy_17_24
> fBodyAccJerk_bandsEnergy_25_32
> fBodyAccJerk_bandsEnergy_33_40
> fBodyAccJerk_bandsEnergy_41_48
> fBodyAccJerk_bandsEnergy_49_56
> fBodyAccJerk_bandsEnergy_57_64
> fBodyAccJerk_bandsEnergy_1_16
> fBodyAccJerk_bandsEnergy_17_32
> fBodyAccJerk_bandsEnergy_33_48
> fBodyAccJerk_bandsEnergy_49_64
> fBodyAccJerk_bandsEnergy_1_24
> fBodyAccJerk_bandsEnergy_25_48
> fBodyAccJerk_bandsEnergy_1_8
> fBodyAccJerk_bandsEnergy_9_16
> fBodyAccJerk_bandsEnergy_17_24
> fBodyAccJerk_bandsEnergy_25_32
> fBodyAccJerk_bandsEnergy_33_40
> fBodyAccJerk_bandsEnergy_41_48
> fBodyAccJerk_bandsEnergy_49_56
> fBodyAccJerk_bandsEnergy_57_64
> fBodyAccJerk_bandsEnergy_1_16
> fBodyAccJerk_bandsEnergy_17_32
> fBodyAccJerk_bandsEnergy_33_48
> fBodyAccJerk_bandsEnergy_49_64
> fBodyAccJerk_bandsEnergy_1_24
> fBodyAccJerk_bandsEnergy_25_48
> fBodyGyro_mean_X
> fBodyGyro_mean_Y
> fBodyGyro_mean_Z
> fBodyGyro_std_X
> fBodyGyro_std_Y
> fBodyGyro_std_Z
> fBodyGyro_mad_X
> fBodyGyro_mad_Y
> fBodyGyro_mad_Z
> fBodyGyro_max_X
> fBodyGyro_max_Y
> fBodyGyro_max_Z
> fBodyGyro_min_X
> fBodyGyro_min_Y
> fBodyGyro_min_Z
> fBodyGyro_sma
> fBodyGyro_energy_X
> fBodyGyro_energy_Y
> fBodyGyro_energy_Z
> fBodyGyro_iqr_X
> fBodyGyro_iqr_Y
> fBodyGyro_iqr_Z
> fBodyGyro_entropy_X
> fBodyGyro_entropy_Y
> fBodyGyro_entropy_Z
> fBodyGyro_maxInds_X
> fBodyGyro_maxInds_Y
> fBodyGyro_maxInds_Z
> fBodyGyro_meanFreq_X
> fBodyGyro_meanFreq_Y
> fBodyGyro_meanFreq_Z
> fBodyGyro_skewness_X
> fBodyGyro_kurtosis_X
> fBodyGyro_skewness_Y
> fBodyGyro_kurtosis_Y
> fBodyGyro_skewness_Z
> fBodyGyro_kurtosis_Z
> fBodyGyro_bandsEnergy_1_8
> fBodyGyro_bandsEnergy_9_16
> fBodyGyro_bandsEnergy_17_24
> fBodyGyro_bandsEnergy_25_32
> fBodyGyro_bandsEnergy_33_40
> fBodyGyro_bandsEnergy_41_48
> fBodyGyro_bandsEnergy_49_56
> fBodyGyro_bandsEnergy_57_64
> fBodyGyro_bandsEnergy_1_16
> fBodyGyro_bandsEnergy_17_32
> fBodyGyro_bandsEnergy_33_48
> fBodyGyro_bandsEnergy_49_64
> fBodyGyro_bandsEnergy_1_24
> fBodyGyro_bandsEnergy_25_48
> fBodyGyro_bandsEnergy_1_8
> fBodyGyro_bandsEnergy_9_16
> fBodyGyro_bandsEnergy_17_24
> fBodyGyro_bandsEnergy_25_32
> fBodyGyro_bandsEnergy_33_40
> fBodyGyro_bandsEnergy_41_48
> fBodyGyro_bandsEnergy_49_56
> fBodyGyro_bandsEnergy_57_64
> fBodyGyro_bandsEnergy_1_16
> fBodyGyro_bandsEnergy_17_32
> fBodyGyro_bandsEnergy_33_48
> fBodyGyro_bandsEnergy_49_64
> fBodyGyro_bandsEnergy_1_24
> fBodyGyro_bandsEnergy_25_48
> fBodyGyro_bandsEnergy_1_8
> fBodyGyro_bandsEnergy_9_16
> fBodyGyro_bandsEnergy_17_24
> fBodyGyro_bandsEnergy_25_32
> fBodyGyro_bandsEnergy_33_40
> fBodyGyro_bandsEnergy_41_48
> fBodyGyro_bandsEnergy_49_56
> fBodyGyro_bandsEnergy_57_64
> fBodyGyro_bandsEnergy_1_16
> fBodyGyro_bandsEnergy_17_32
> fBodyGyro_bandsEnergy_33_48
> fBodyGyro_bandsEnergy_49_64
> fBodyGyro_bandsEnergy_1_24
> fBodyGyro_bandsEnergy_25_48
> fBodyAccMag_mean
> fBodyAccMag_std
> fBodyAccMag_mad
> fBodyAccMag_max
> fBodyAccMag_min
> fBodyAccMag_sma
> fBodyAccMag_energy
> fBodyAccMag_iqr
> fBodyAccMag_entropy
> fBodyAccMag_maxInds
> fBodyAccMag_meanFreq
> fBodyAccMag_skewness
> fBodyAccMag_kurtosis
> fBodyBodyAccJerkMag_mean
> fBodyBodyAccJerkMag_std
> fBodyBodyAccJerkMag_mad
> fBodyBodyAccJerkMag_max
> fBodyBodyAccJerkMag_min
> fBodyBodyAccJerkMag_sma
> fBodyBodyAccJerkMag_energy
> fBodyBodyAccJerkMag_iqr
> fBodyBodyAccJerkMag_entropy
> fBodyBodyAccJerkMag_maxInds
> fBodyBodyAccJerkMag_meanFreq
> fBodyBodyAccJerkMag_skewness
> fBodyBodyAccJerkMag_kurtosis
> fBodyBodyGyroMag_mean
> fBodyBodyGyroMag_std
> fBodyBodyGyroMag_mad
> fBodyBodyGyroMag_max
> fBodyBodyGyroMag_min
> fBodyBodyGyroMag_sma
> fBodyBodyGyroMag_energy
> fBodyBodyGyroMag_iqr
> fBodyBodyGyroMag_entropy
> fBodyBodyGyroMag_maxInds
> fBodyBodyGyroMag_meanFreq
> fBodyBodyGyroMag_skewness
> fBodyBodyGyroMag_kurtosis
> fBodyBodyGyroJerkMag_mean
> fBodyBodyGyroJerkMag_std
> fBodyBodyGyroJerkMag_mad
> fBodyBodyGyroJerkMag_max
> fBodyBodyGyroJerkMag_min
> fBodyBodyGyroJerkMag_sma
> fBodyBodyGyroJerkMag_energy
> fBodyBodyGyroJerkMag_iqr
> fBodyBodyGyroJerkMag_entropy
> fBodyBodyGyroJerkMag_maxInds
> fBodyBodyGyroJerkMag_meanFreq
> fBodyBodyGyroJerkMag_skewness
> fBodyBodyGyroJerkMag_kurtosis
> angletBodyAccMean_gravity
> angletBodyAccJerkMean_gravityMean
> angletBodyGyroMean_gravityMean
> angletBodyGyroJerkMean_gravityMean
> angleX_gravityMean
> angleY_gravityMean
> angleZ_gravityMean

```
