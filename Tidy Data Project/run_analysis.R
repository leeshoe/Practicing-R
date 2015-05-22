run_analysis <- function() {
    
    # Getting and Cleaning Data Project: UCI HAR dataset. See dataset details here:
    # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    # Local dataset is in this directory: ./Tidy Data Project/UCI HAR Dataset/
    
    # PROJECT OBJECTIVE: create one R script called run_analysis.R to perform the following 5 steps.
        # STEP 1. Merges the training and the test sets to create one data set.
        # STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
        # STEP 3. Uses descriptive activity names to name the activities in the data set
        # STEP 4. Appropriately labels the data set with descriptive variable names. 
        # STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    library(dplyr)

# STEP 1. Merges the training and the test sets to create one data set.

# There are twelve types of files making up the test and train datasets together. Only three of those twelve types provide mean and standard deviation data for subject measurements. Therefore, this script will read only from those three types of files. 
    
        # A. Retrieve full list of subject ID #s
    subject.test <- 
        read.table("Tidy Data Project/UCI HAR Dataset/test/subject_test.txt", 
                   header = FALSE, col.names = "subjectID")
    subject.train <- 
        read.table("Tidy Data Project/UCI HAR Dataset/train/subject_train.txt", 
                   header = FALSE, col.names = "subjectID")
    subject.all <- rbind(subject.test, subject.train)

        # B. Retrieve full list of 561-feature vector with time and frequency domain variables.
    x.test <- 
        read.table("Tidy Data Project/UCI HAR Dataset/test/X_test.txt", 
                   header = FALSE)
    x.train <- 
        read.table("Tidy Data Project/UCI HAR Dataset/train/X_train.txt", 
                   header = FALSE)
    x.all <- rbind(x.test, x.train)

        # C. Retrieve full list of activity label IDs (one variable, ID range 1:6)
    y.test <- 
        read.table("Tidy Data Project/UCI HAR Dataset/test/y_test.txt", 
                   header = FALSE, col.names = "activity_labelID")
    y.train <- 
        read.table("Tidy Data Project/UCI HAR Dataset/train/y_train.txt", 
                   header = FALSE, col.names = "activity_labelID")
    y.all <- rbind(y.test, y.train)
    
        # D. Combine the three types of raw data in one dataframe.
    raw.data.combined <- cbind(subject.all, y.all, x.all)
    
# STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    # This part of the script uses the grep() function to search the features.txt file in the UCI HAR Data set for strings "mean()" and "std()", returning IDs that correspond to grep() matches. These ID numerals will correspond to the V1:V561 column headings in raw.data.combined.
    # The regular expression used by grep() actually fetches three types of feature, as defined in features.txt:
        # mean(): Mean value
        # std(): Standard deviation
        # meanFreq(): Weighted average of the frequency components to obtain a mean frequency
            # this third feature is another type of mean, so it seems it belongs in the project spec.
    # It will not search for the features from the end of features.txt, which use an angle() function to calculate dot products using two input vectors. In this dataset these input vectors are themselves means (in most cases) but the output of this calculation is not itself necessarily a mean of these subjects, so I've omitted these features.
    features <- 
        read.table("Tidy Data Project/UCI HAR Dataset/features.txt", 
                   header = FALSE, col.names = c("featureID", "feature"))
    mean.std.ID <- grep("(mean|std)()", features$feature)
    mean.std.features <- features[mean.std.ID, ]
    mean.std.features$Vcolumns <- paste("V", mean.std.features$featureID, sep="")
    har.data.mean.std.extract <- raw.data.combined[ , mean.std.features$Vcolumns]
    har.data.full <- cbind(raw.data.combined[1:2], har.data.mean.std.extract)

# STEP 3. Uses descriptive activity names to name the activities in the data set

    activity.labels <- 
        read.table("Tidy Data Project/UCI HAR Dataset/activity_labels.txt", 
                   header = FALSE, col.names = c("activity_labelID", "activity_label"))
    har.data.full$activity_label <- 
        activity.labels$activity_label[
            match(har.data.full$activity_labelID, activity.labels$activity_labelID)
            ]
    har.data.full <- har.data.full[ , c(1, 82, 3:81)]

# STEP 4. Appropriately labels the data set with descriptive variable names. 
    
    colnames(har.data.full)[3:81] <- as.character(mean.std.features$feature)
    # as.character() function converts feature factor to text values. If I don't do this,
    # it assigns numeric factor codes to colnames() ... and that wouldn't be very
    # descriptive!

# STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# there's also summarise_each() -- note that it takes british spelling only, not "summarize".
# http://stackoverflow.com/questions/22644804/how-can-i-use-dplyr-to-apply-a-function-to-all-non-group-by-columns
#    har.data.full.grouped <- group_by(har.data.full, subjectID, activity_label)
#    har.tidy <- summarise_each(har.data.full.grouped, funs(mean))

    har.tidy <- har.data.full %>% group_by(subjectID, activity_label) %>% summarise_each(funs(mean))

# Final step is to write the tidy dataset to a file.

if (!file.exists("Tidy Data Project/har_tidy_output.txt")) {

        write.table(har.tidy, "Tidy Data Project/har_tidy_output.txt", row.name=FALSE)
    
    } else { 
    
        "Error: har_tidy_output.txt file already exists in Tidy Data Project directory." 

    }

}