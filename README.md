# get_n_clean_data

## Getting and Cleaning Data Course project

This repository contains three files
* README.md: this document
* CodeBook.md: Describes the variables, the data, and any transformations or work that I performed
* run_analysis.R: Script used to analyze the data
 

## The run_analysis.R script works as follows:

### Step 0 (file download)
Downloaws from the URL a file "dataset.zip" and stores it into the working directory 

### Step 1: Merges the training and the test sets to create one data set
* The function unz() is used to unzip the files within the zip file
* Each file is read with read.table() which returns a data.frame
* The dataframes TstS and TrnS contain the subject of the test and train datasets
* The dataframes TstY and TrnY contain the ID of the Activity each individual was performing at a given time
* The datafremes TstX and TrnX contain the bulk of the data, which names are given from Features (see below)
* Features contains the names of the variables stored in features.txt
* Once all the data has been retrieved, a dataframe tbl is generated by combining all the information

To combine the information
* the columns of dataframe(Subject = ..., Activity = ..., Type = ...) are as follows:
* - Subject: is obtained by simply concatenating with c() the data from subject_test.txt and subject_train.txt
* - Activity: is also obtained by concatenating the data from y_test.txt and y_train.txt
* - Type: is not used later, but stores the origin of the information (test or train)
* rbind(TstX, TrnX) produces a dataframe with X_test.txt + X_train.txt
* the two dataframes above are combined with cbind() and converted into a data frame tbl with tbl_df() 


### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
* the function grep() is used to find the strings "mean" and "std" within the names of the dataset
* since we first have all the means and later all the std, with intersect() we obtain the names in the original sequence
* then select() is called with one_of() to extranct the measures we are interested in


### Setp 3: Uses descriptive activity names to name the activities in the data set
* the activity names are contained in activity_labels.txt
* the vector ActNames contains the same information than activity_labels
* ActNames[DS1$Activity] is a vector with strings instead of activity numbers
* these names are converted to a factor with factor()
* by using the levels parameter we make sure that the activity has the same number as in the original


### Step 4: Appropriately labels the data set with descriptive variable names
* Feature is a vector conatining the names of the fields sotred in features.txt
* This vector was assigned to col.names when reading the datasets subject_test.txt and subject_train.txt
* However, the names contain some characters like "_" or "(" that R converts to "."
* For instance tBodyAcc-mean()-X is converted to tBodyAcc.mean...X
* To clear out all the dots gsub is used to replace the regular expression [.]+ by a sinble underscore
* [.]+ means one or more instances of the character "."


### Step 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
* The dataset DS2 is creted from DS1
* group_by() is used to split the records containing the same Activity and Subject
* then the function summarise_each() is used to get the mean of each column
* the final result is stored into a file using write.table

