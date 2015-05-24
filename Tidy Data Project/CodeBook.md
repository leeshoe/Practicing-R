This CodeBook covers the procedure and the data dictionary for composing a tidy data set of mean and standard deviation measurements from the following "Human Activity Recognition Using Smartphones Data Set":
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

<strong>Procedure</strong>

The script run_analysis.R tidies the UCI HAR data set by performing the following steps:
<ul>
<li>STEP 1. Merges the training and the test sets to create one data set.</li>
<ul>
<li>There are twelve types of files making up the test and train datasets together. Only three of those twelve types provide mean and standard deviation data for subject measurements. Therefore, this script will read only from those three types of files.</li>
<li>The data in these three types of file are:</li>
<ol>
<li>A single-variable list of subject IDs (people whose smartphones took motion measurements)</li>
<li>A 561-feature vector with time and frequency domain variables.</li>
<li>A single-variable list of activity label IDs (ID range is 1:6).</li>
</ol>
<li>The three types of data are then combined in a single data set variable called raw.data.combined, in the order of subjectID, activity_labelID, and then the 561 time and frequency domain variables.</li> 
</ul>
<li>STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement.</li>
<ul>
<li>This part of the script uses the grep() function to search the UCI HAR Data set features.txt file for strings "mean()" and "std()", returning IDs that correspond to grep() matches. These ID numerals will correspond to the V1:V561 column headings in raw.data.combined.</li>
<li>The regular expression used by grep() actually fetches three types of feature, as defined in features.txt:</li>
<ol>
<li>mean(): Mean value</li>
<li>std(): Standard deviation</li>
<li>meanFreq(): Weighted average of the frequency components to obtain a mean frequency</li>
</ol>
<li>It will not search for the features from the end of features.txt, which use an angle() function to calculate dot products using two input vectors. In this dataset these input vectors are themselves means (in most cases) but the output of this calculation is not itself necessarily a mean of these subjects, so I've omitted these features.</li>
</ol>
</ul>
<li>STEP 3. Uses descriptive activity names to name the activities in the data set</li>
<ul>
<li>Replace the column of activity_labelID numbers with the corresponding text from the UCI HAR Data set file activity_labels.txt.</li>
</ul>
<li>STEP 4. Appropriately labels the data set with descriptive variable names.</li>
<ul>
<li>Feature measurement column names are taken from the UCI HAR Data set features.txt file. The script uses text substitution to convert them into self-explanatory column names. The column name format is described in the Data Dictionary section below.</li>
</ul>
<li>STEP 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
<ul>
<li>Tidiness in this solution is achieved in "wide format", meaning that the rows are grouped by a combination of subjectID and activity.label.</li>
<li>Therefore, each of 30 subjects will have 6 rows of feature measurements, one for each activity.label:</li>
<ol>
<li>LAYING</li>
<li>SITTING</li>
<li>STANDING</li>
<li>WALKING</li>
<li>WALKING_DOWNSTAIRS</li>
<li>WALKING_UPSTAIRS</li>
</ol>
<li>The remaining 79 columns are averages of the measurements taken for each combined subject/activity.</li>
</ul>
</ul>

<strong>Data Dictionary:</strong>

 [1] "subjectID"
<ul>
<li>integer range 1:30</li>
<li>Identifies a Samsung phone used by a person in the study.</li>
</ul>
 [2] "activity.label"                                                       
<ul>
<li>factor with six levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS</li>
<li>Identifies an activity performed by the subject at the time of feature measurements.</li>
</ul>

The remaining 79 variables are averaged mean and standard deviation measurements of the above subject/activity groupings. They are all numeric variables. 

The column names are derived from the original UCI HAR Data set features.txt file, modified to provide maximally readable self-explanatory labels. The UCI HAR features.txt file packs four types of information into the original feature names. The tidied output breaks up these four types of information using double-colons (::), and breaks up other terms with periods.

The tidied columns follow this specific format:
<ul>
<li>"measurement.domain::measurement.type::calculation::vector.axis"</li>
<ol>
<li>measurement.domain refers to time or frequency. Every variable is one or the other.</li>
<li>measurement.type refers to accelerometer, gyroscope, body, jerk, or magnitude. Every variable will be some combination of one or more of these.</li>
<li>calculation refers to mean, stddev (standard deviation), or meanfrequency. Every variable will have been derived by one and only one of these calculations.</li>
<li>vector.axis refers to X, Y, or Z. Not all variables have a vector axis. Those that do will have only one of the three possible axes.</li>
</ol>
</ul>

 [3] "time.domain::body.acceleration.mean::x.axis"                          
 [4] "time.domain::body.acceleration.mean::y.axis"                          
 [5] "time.domain::body.acceleration.mean::z.axis"                          
 [6] "time.domain::body.acceleration.stddev::x.axis"                        
 [7] "time.domain::body.acceleration.stddev::y.axis"                        
 [8] "time.domain::body.acceleration.stddev::z.axis"                        
 [9] "time.domain::gravity.acceleration.mean::x.axis"                       
[10] "time.domain::gravity.acceleration.mean::y.axis"                       
[11] "time.domain::gravity.acceleration.mean::z.axis"                       
[12] "time.domain::gravity.acceleration.stddev::x.axis"                     
[13] "time.domain::gravity.acceleration.stddev::y.axis"                     
[14] "time.domain::gravity.acceleration.stddev::z.axis"                     
[15] "time.domain::body.acceleration.jerk.mean::x.axis"                     
[16] "time.domain::body.acceleration.jerk.mean::y.axis"                     
[17] "time.domain::body.acceleration.jerk.mean::z.axis"                     
[18] "time.domain::body.acceleration.jerk.stddev::x.axis"                   
[19] "time.domain::body.acceleration.jerk.stddev::y.axis"                   
[20] "time.domain::body.acceleration.jerk.stddev::z.axis"                   
[21] "time.domain::body.gyroscope.mean::x.axis"                             
[22] "time.domain::body.gyroscope.mean::y.axis"                             
[23] "time.domain::body.gyroscope.mean::z.axis"                             
[24] "time.domain::body.gyroscope.stddev::x.axis"                           
[25] "time.domain::body.gyroscope.stddev::y.axis"                           
[26] "time.domain::body.gyroscope.stddev::z.axis"                           
[27] "time.domain::body.gyroscope.jerk.mean::x.axis"                        
[28] "time.domain::body.gyroscope.jerk.mean::y.axis"                        
[29] "time.domain::body.gyroscope.jerk.mean::z.axis"                        
[30] "time.domain::body.gyroscope.jerk.stddev::x.axis"                      
[31] "time.domain::body.gyroscope.jerk.stddev::y.axis"                      
[32] "time.domain::body.gyroscope.jerk.stddev::z.axis"                      
[33] "time.domain::body.acceleration.magnitude.mean"                        
[34] "time.domain::body.acceleration.magnitude.stddev"                      
[35] "time.domain::gravity.acceleration.magnitude.mean"                     
[36] "time.domain::gravity.acceleration.magnitude.stddev"                   
[37] "time.domain::body.acceleration.jerk.magnitude.mean"                   
[38] "time.domain::body.acceleration.jerk.magnitude.stddev"                 
[39] "time.domain::body.gyroscope.magnitude.mean"                           
[40] "time.domain::body.gyroscope.magnitude.stddev"                         
[41] "time.domain::body.gyroscope.jerk.magnitude.mean"                      
[42] "time.domain::body.gyroscope.jerk.magnitude.stddev"                    
[43] "frequency.domain::body.acceleration.mean::x.axis"                     
[44] "frequency.domain::body.acceleration.mean::y.axis"                     
[45] "frequency.domain::body.acceleration.mean::z.axis"                     
[46] "frequency.domain::body.acceleration.stddev::x.axis"                   
[47] "frequency.domain::body.acceleration.stddev::y.axis"                   
[48] "frequency.domain::body.acceleration.stddev::z.axis"                   
[49] "frequency.domain::body.acceleration.meanfrequency::x.axis"            
[50] "frequency.domain::body.acceleration.meanfrequency::y.axis"            
[51] "frequency.domain::body.acceleration.meanfrequency::z.axis"            
[52] "frequency.domain::body.acceleration.jerk.mean::x.axis"                
[53] "frequency.domain::body.acceleration.jerk.mean::y.axis"                
[54] "frequency.domain::body.acceleration.jerk.mean::z.axis"                
[55] "frequency.domain::body.acceleration.jerk.stddev::x.axis"              
[56] "frequency.domain::body.acceleration.jerk.stddev::y.axis"              
[57] "frequency.domain::body.acceleration.jerk.stddev::z.axis"              
[58] "frequency.domain::body.acceleration.jerk.meanfrequency::x.axis"       
[59] "frequency.domain::body.acceleration.jerk.meanfrequency::y.axis"       
[60] "frequency.domain::body.acceleration.jerk.meanfrequency::z.axis"       
[61] "frequency.domain::body.gyroscope.mean::x.axis"                        
[62] "frequency.domain::body.gyroscope.mean::y.axis"                        
[63] "frequency.domain::body.gyroscope.mean::z.axis"                        
[64] "frequency.domain::body.gyroscope.stddev::x.axis"                      
[65] "frequency.domain::body.gyroscope.stddev::y.axis"                      
[66] "frequency.domain::body.gyroscope.stddev::z.axis"                      
[67] "frequency.domain::body.gyroscope.meanfrequency::x.axis"               
[68] "frequency.domain::body.gyroscope.meanfrequency::y.axis"               
[69] "frequency.domain::body.gyroscope.meanfrequency::z.axis"               
[70] "frequency.domain::body.acceleration.magnitude.mean"                   
[71] "frequency.domain::body.acceleration.magnitude.stddev"                 
[72] "frequency.domain::body.acceleration.magnitude.meanfrequency"          
[73] "frequency.domain::body.body.acceleration.jerk.magnitude.mean"         
[74] "frequency.domain::body.body.acceleration.jerk.magnitude.stddev"       
[75] "frequency.domain::body.body.acceleration.jerk.magnitude.meanfrequency"

[76] "frequency.domain::body.body.gyroscope.magnitude.mean"                 
[77] "frequency.domain::body.body.gyroscope.magnitude.stddev"               
[78] "frequency.domain::body.body.gyroscope.magnitude.meanfrequency"        
[79] "frequency.domain::body.body.gyroscope.jerk.magnitude.mean"            
[80] "frequency.domain::body.body.gyroscope.jerk.magnitude.stddev"          
[81] "frequency.domain::body.body.gyroscope.jerk.magnitude.meanfrequency"
