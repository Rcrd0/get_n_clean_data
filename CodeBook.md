#CodeBook.md

The datasets are obtained and transoformed as explained in the README.md document:
https://github.com/Rcrd0/get_n_clean_data/blob/master/README.md

# Dataset DS1
Contains one row per observation with the following fields:
* Subject: identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
* Activity:  
    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING
* NAME_STAT_[-XYZ]: 79 fields containing the mean and standard deviation of the signals used to estimate the Activity
  NAME can be one of the following:
        tBodyAcc-XYZ
        tGravityAcc-XYZ
        tBodyAccJerk-XYZ
        tBodyGyro-XYZ
        tBodyGyroJerk-XYZ
        tBodyAccMag
        tGravityAccMag
        tBodyAccJerkMag
        tBodyGyroMag
        tBodyGyroJerkMag
        fBodyAcc-XYZ
        fBodyAccJerk-XYZ
        fBodyGyro-XYZ
        fBodyAccMag
        fBodyAccJerkMag
        fBodyGyroMag
        fBodyGyroJerkMag
  _STAT_ can be one of the following:
        _mean_: the mean of the signal
        _std_: the standard deviation of the signal
  -XYZ, if NAME finishes by -XYZ implies that there are 3 variables for that signal, one per each direction
    
# dataset DS2
Contains the same fields than DS1, but each row representes the average of the subject and activity. 

For instance:
* in dataset DS1, tBodyAcc_std_Y records one observation of the standard deviations of the signal tBodyAcc for the Y direction
* in dataset DS2, tBodyAcc_std_Y records the mean of all the observations for a given individual and activity (in this case, the mean of the standard deviations)
 
