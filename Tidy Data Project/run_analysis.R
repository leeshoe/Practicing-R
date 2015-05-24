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
    
    # You will need this library for the data wrangling in Step 5.
    library(dplyr)

    if (!file.exists("Tidy Data Project")) {
        dir.create("Tidy Data Project")
    }
    
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
                   header = FALSE, col.names = "activity.labelID")
    y.train <- 
        read.table("Tidy Data Project/UCI HAR Dataset/train/y_train.txt", 
                   header = FALSE, col.names = "activity.labelID")
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
                   header = FALSE, col.names = c("activity.labelID", "activity.label"))

    har.data.full$activity.label <- 
        activity.labels$activity.label[
            match(har.data.full$activity.labelID, activity.labels$activity.labelID)
            ]
    har.data.full <- har.data.full[ , c(1, 82, 3:81)] # omits ID column 2 on purpose

# STEP 4. Appropriately labels the data set with descriptive variable names. 
    
    # These text substitution functions expand abbreviated features to more descriptive
    # terms. For maximum readability, I separate words by periods, and information 
    # types by double-colons. The UCI HAR data basically pack four pieces of information 
    # into the feature name. My tidied format is,
    # "measurement.domain::measurement.type::calculation::vector.axis"
        # measurement.domain refers to time or frequency.
    mean.std.features$descriptive <- sub("^t", "time.domain::", mean.std.features$feature)
    mean.std.features$descriptive <- sub("^f", "frequency.domain::", mean.std.features$descriptive)
        # measurement.type refers to accelerometer, gyroscope, body, jerk, magnitude.
    mean.std.features$descriptive <- sub("Acc", ".acceleration", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("Jerk", ".jerk", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("Gyro", ".gyroscope", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("Mag", ".magnitude", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("BodyBody", "body.body", mean.std.features$descriptive)
        # calculation refers to mean, stddev (standard deviation), or meanfrequency.
    mean.std.features$descriptive <- sub("-mean\\(\\)", "::mean", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("-std\\(\\)", "::stddev", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("-meanFreq\\(\\)", "::meanfrequency", mean.std.features$descriptive)
        # vector.axis refers to X, Y, or Z.
    mean.std.features$descriptive <- sub("-X", "::x.axis", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("-Y", "::y.axis", mean.std.features$descriptive)
    mean.std.features$descriptive <- sub("-Z", "::z.axis", mean.std.features$descriptive)
        # One last tidying step, make it all lowercase.
    mean.std.features$descriptive <- tolower(mean.std.features$descriptive)

    # This function changes the column names of my tidied har.data.full data frame.
    colnames(har.data.full)[3:81] <- as.character(mean.std.features$descriptive)
    # as.character() function converts feature factor to text values. If I don't do this,
    # it assigns numeric factor codes to colnames() ... and that wouldn't be very
    # descriptive!

# STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# there's also summarise_each() -- note that it takes british spelling only, not "summarize".
# http://stackoverflow.com/questions/22644804/how-can-i-use-dplyr-to-apply-a-function-to-all-non-group-by-columns

    har.tidy <- har.data.full %>% group_by(subjectID, activity.label) %>% summarise_each(funs(mean))

# Final step is to write the tidy dataset to a file in the working directory.

if (!file.exists("Tidy Data Project/har_tidy_output.txt")) {

        write.table(har.tidy, "Tidy Data Project/har_tidy_output.txt", row.name=FALSE)
    
    } else { 
    
        "Error: har_tidy_output.txt file already exists in Tidy Data Project directory." 

    }

}