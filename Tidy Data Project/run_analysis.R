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
    # UPDATE: I think I only need merge #1-3, and skip all the inertial data, since the inertial data
    # don't contribute to the measurements for STEP 2.
    
        # 1. retrieve full list of subject ID #s
    subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "subjectID")
    subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "subjectID")
    subjectall <- rbind(subjecttest, subjecttrain)
        # 2. retrieve full list of 561-feature vector with time and frequency domain variables.
    xtest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
    xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
    xall <- rbind(xtest, xtrain)
        # 3. retrieve full list of activity label IDs (one variable, range 1:6)
    ytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = "activity_labelID")
    ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = "activity_labelID")
    yall <- rbind(ytest, ytrain)
    
        # combine in one dataframe
    fulldata <- cbind(subjectall, yall, xall)
    
# STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    # Strategy: search features.txt for strings "mean()" and "std()", return IDs that correspond
    # to the numerals in the V1:V561 column names. The grep regular expression actually fetches three
    # features, as defined in features.txt:
        # mean(): Mean value
        # std(): Standard deviation
        # meanFreq(): Weighted average of the frequency components to obtain a mean frequency
            # this third feature is another type of mean, so it seems it belongs in the project spec.
    features <- read.table("UCI HAR Dataset/features.txt", header = FALSE, col.names = c("featureID", "feature"))
    meanstdID <- grep("(mean|std)()", features$feature)
    meanstd_features <- features[meanstdID,]
    meanstd_features$Vcolumns <- paste("V", meanstd_features$featureID, sep="")
    meanstd_extract <- fulldata[ , meanstd_features$Vcolumns]
    meanstd_fulldata <- cbind(fulldata[1:2], meanstd_extract)

# STEP 3. Uses descriptive activity names to name the activities in the data set

    activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("activity_labelID", "activity_label"))
    # this next bit puts column at very end, #82... maybe move it around? Or replace the ID column?
    meanstd_fulldata$activity_label <- activity_labels$activity_label[match(meanstd_fulldata$activity_labelID, activity_labels$activity_labelID)]
    meanstd_fulldata <- meanstd_fulldata[ , c(1, 82, 3:81)] # reorder columns: drop activity_labelID and
                                                            # move activity_label factor names to #2 spot

# STEP 4. Appropriately labels the data set with descriptive variable names. 
    
    colnames(meanstd_fulldata)[3:81] <- as.character(meanstd_features$feature)
    # as.character() function converts feature factor to text values. If I don't do this,
    # it assigns numeric factor codes to colnames() ... and that wouldn't be very
    # descriptive!

# STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.




#if (!file.exists("")) {
 #   write.table() using row.name=FALSE
#}




}