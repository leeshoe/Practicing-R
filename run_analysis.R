run_analysis <- function() {
    
    # You should create one R script called run_analysis.R that does the following. 

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
    
    
        # 4. retrieve full list of The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector.
    total_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE)
    total_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE)
    total_acc_x_all <- rbind(total_acc_x_test, total_acc_x_train)
        # 5. retrieve full list of The acceleration signal from the smartphone accelerometer Y axis in standard gravity units 'g'. Every row shows a 128 element vector.
    total_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE)
    total_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE)
    total_acc_y_all <- rbind(total_acc_y_test, total_acc_y_train)
        # 6. retrieve full list of The acceleration signal from the smartphone accelerometer Z axis in standard gravity units 'g'. Every row shows a 128 element vector.
    total_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE)
    total_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE)
    total_acc_z_all <- rbind(total_acc_z_test, total_acc_z_train)
        # 7. retrieve full list of X body acceleration signal obtained by subtracting the gravity from the total acceleration.
    body_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE)
    body_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE)
    body_acc_x_all <- rbind(body_acc_x_test, body_acc_x_train)
        # 8. retrieve full list of Y body acceleration signal obtained by subtracting the gravity from the total acceleration.
    body_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE)
    body_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE)
    body_acc_y_all <- rbind(body_acc_y_test, body_acc_y_train)
        # 9. retrieve full list of Z body acceleration signal obtained by subtracting the gravity from the total acceleration.
    body_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE)
    body_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE)
    body_acc_z_all <- rbind(body_acc_z_test, body_acc_z_train)
        # 10. retrieve full list of X angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
    body_gyro_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE)
    body_gyro_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE)
    body_gyro_x_all <- rbind(body_gyro_x_test, body_gyro_x_train)
        # 11. retrieve full list of Y angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
    body_gyro_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE)
    body_gyro_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE)
    body_gyro_y_all <- rbind(body_gyro_y_test, body_gyro_y_train)
        # 12. retrieve full list of Z angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
    body_gyro_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE)
    body_gyro_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE)
    body_gyro_z_all <- rbind(body_gyro_z_test, body_gyro_z_train)
    
    # Now that we have both datasets combined in twelve data frames, 
    # write them to new files in a new "all" directory.
    # ACTUALLY do I want to do this or do I just move to the next step
    # and work within memory?
    if (!file.exists("UCI HAR Dataset/all")) {
        dir.create("UCI HAR Dataset/all")
    }
    
    
# STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# STEP 3. Uses descriptive activity names to name the activities in the data set
# STEP 4. Appropriately labels the data set with descriptive variable names. 

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



}