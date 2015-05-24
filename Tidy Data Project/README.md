This is my solution to the project for the Coursera Getting and Cleaning Data class, taught by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD. The following description of the project comes from the course website:

<i>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained, "Human Activity Recognition Using Smartphones Data Set":</i>
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


My solution to the project is in these five repo files:

<ol>
<li>run_analysis.R: a single R script that imports data from multiple files and outputs a single tidy data set to file. This script has detailed comments throughout.</li>
<li>har_tidy_output.txt: the tidy data set output file. This script was written on an Ubuntu system. The file location is a subdirectory to the R working directory, /Tidy Data Project/. The script will test for the existence of that directory ... if it doesn't exist, it will attempt to create it.</li>
<li>UCI HAR Dataset subdirectory to the R working directory. This is the 'messy' source data, and you'll need it if you want to test my script. Download it from my repo or from the link provided in class: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</li>
<li>CodeBook.md: this file describes the variables, the data, and transformations performed to tidy the data.</li>
<li>This ReadMe.md file.
</ol>

For more information about the project, see these links:

<ol>
<li>David Hood's tidy data discussion (this will not be available to folks who aren't registered for the class): https://class.coursera.org/getdata-014/forum/thread?thread_id=31</li>
<li>Tidy data article by Hadley Wickham: http://vita.had.co.nz/papers/tidy-data.pdf</li>
</ol>

Author: Tim Shores
5/23/2015