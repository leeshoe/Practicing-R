run_analysis <- function() {
    
    # Getting and Cleaning Data Project: UCI HAR dataset. See dataset details here:
    # Local dataset in directory: ./UCI HAR Dataset/
    # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    # PROJECT OBJECTIVE: create one R script called run_analysis.R to perform the following 5 steps.
    
    # STEP 1. Merges the training and the test sets to create one data set.
    # STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    # STEP 3. Uses descriptive activity names to name the activities in the data set
    # STEP 4. Appropriately labels the data set with descriptive variable names. 
    # STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# STEP 1. Merges the training and the test sets to create one data set.
    # There are twelve file types split between the test and train datasets. The following twelve groups
    # of code merge each into an "all" file.
    # UPDATE: I think I only need merge #1-3, and skip all the inertial data.
    
        # 1. retrieve full list of subject ID #s
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "subject")
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "subject")
    subject_all <- rbind(subject_test, subject_train)
        # 2. retrieve full list of 561-feature vector with time and frequency domain variables.
    X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
    X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
    X_all <- rbind(X_test, X_train)
        # 3. retrieve full list of activity label IDs. (range 1:6)
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
    y_all <- rbind(y_test, y_train)
    
    # Now that we have both datasets combined in twelve data frames, 
    # write them to new files in a new "all" directory.
    # ACTUALLY do I want to do this or do I just move to the next step
    # and work within memory?
    if (!file.exists("UCI HAR Dataset/all")) {
        dir.create("UCI HAR Dataset/all")
    }
    
    
# STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

    # merge() after adding id columns? or dplyr join_all()
    # dfList = list(df1,df2,df3); join_all(dfList)

# STEP 3. Uses descriptive activity names to name the activities in the data set
# STEP 4. Appropriately labels the data set with descriptive variable names. 

# STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



}