#--------------------------------- 0 Downloads and unzip the files

    library(downloader)    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download(fileUrl, "dataset.zip", mode = "wb")
    
    
#--------------------------------- 1 Merges the training and the test sets to create one data set.
    library(dplyr)
    
    
    # read the subject IDs for each row of Test and Train ...
    TstS <- read.table(unz("dataset.zip", "UCI HAR Dataset/test/subject_test.txt"), header=FALSE, col.names = "Subject")
    TrnS <- read.table(unz("dataset.zip","UCI HAR Dataset/train/subject_train.txt"), header=FALSE, col.names = "Subject")
               
    
    # read the activities
    TstY <- read.table(unz("dataset.zip", "UCI HAR Dataset/test/y_test.txt"), header=FALSE, col.names = "Activity")
    TrnY <- read.table(unz("dataset.zip", "UCI HAR Dataset/train/y_train.txt"), header=FALSE, col.names = "Activity")

    # read the file features.txt which contains the names of all the fields
    Features <- read.table(unz("dataset.zip", "UCI HAR Dataset/features.txt"))$V2
    
    # Read X files using the names of the features which no longer contain "()"
    TstX <- read.table(unz("dataset.zip", "UCI HAR Dataset/test/X_test.txt"), header=FALSE, col.names = Features)
    TrnX <- read.table(unz("dataset.zip", "UCI HAR Dataset/train/X_train.txt"), header=FALSE, col.names = Features)
    
    DS1 <- tbl_df(
        cbind (                                                                 # merges by column
            data.frame(                                                         # ... the dataframe 
                Subject = c(TstS$Subject, TrnS$Subject),                        # ...... with the subejcts from the two sets
                Activity = c(TstY$Activity, TrnY$Activity),                     # ...... together with their activities
                Type = c(rep("Test", nrow(TstS)), rep("Train", nrow(TrnS)))),   # ...... and the source of the data
            rbind(TstX, TrnX)))                                                 # ... with all the columns of TstX and TrnX combineds

#--------------------------------- 2 Extracts only the measurements on the mean and standard deviation for each measurement
    
    # compose the vector of columns to be selected (grep is used to find names containing "mean" and "std"
    ColNames <- c("Subject", "Activity", grep("mean", names(DS1), value=TRUE), grep("std", names(DS1), value=TRUE))
    
    # sort the vecor in the same sequence than in the original dataset
    ColNames <- intersect(names(DS1), ColNames)

    # select the columns
    DS1 <- DS1 %>% select(one_of(ColNames))
    
#--------------------------------- 3 Uses descriptive activity names to name the activities in the data set
    
    # create a vector with the names
    ActNames <- c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
    
    # transform DS1$Activity into a factor
    DS1$Activity  <- factor(ActNames[DS1$Activity], levels = ActNames)
    
    
    
#--------------------------------- 4 Appropriately labels the data set with descriptive variable names
    
    # replace one or more dots in the variable names by underscore    
    names(DS1) <- gsub("[.]+", "_", names(DS1))
    
    
    
#--------------------------------- 5 From the data set in step 4, creates a second, independent tidy data set 
#                                    with the average of each variable for each activity and each subject.
    
    DS2 <- DS1 %>%                          # Data set 2 is built from the data set in step 4
        group_by(Activity, Subject) %>%     # grouped by Activity and subject
        summarise_each(funs(mean))          # applying the mean to each variable
    
    
    # upload your data set as a txt file created with write.table() using row.name=FALSE
    write.table(DS2, file="./data/dataset2.txt", row.name=FALSE)
    
    
