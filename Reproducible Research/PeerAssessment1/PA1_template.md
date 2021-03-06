# Johns Hopkins/Coursera - Reproducible Research: Peer Assessment 1
Tim Shores  
## Introduction

It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a [Fitbit](http://www.fitbit.com), [Nike Fuelband](http://www.nike.com/us/en_us/c/nikeplus-fuelband), or [Jawbone Up](https://jawbone.com/up). These type of devices are part of the "quantified self" movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

This assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

## Data

The data for this assignment can be downloaded from the course web site:

* Dataset: [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) [52K]

The variables included in this dataset are:

* **steps**: Number of steps taking in a 5-minute interval (missing
    values are coded as `NA`)

* **date**: The date on which the measurement was taken in YYYY-MM-DD
    format

* **interval**: Identifier for the 5-minute interval in which
    measurement was taken

The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.

## Procedure

The first task is to load any non-base libraries that my scripts will use. I'll detach these at the end of the presentation.


```r
library(dplyr) # for data wrangling
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2) # for good looking plots
```

## Loading and preprocessing the data

To answer the first few question, I decided to filter NA values from the steps data during import from the file. I will need to import the file again later when NA values become relevant to the analysis.


```r
datapath <- 
    paste("/home/tim/datasciencecoursera/Practicing-R/Reproducible Research/PeerAssessment1/activity.csv")
act <- read.csv(datapath) %>% filter(!is.na(steps))
act.steps.grouped <- group_by(act, date) # enables analysis by date factor.
act.steps.summary <- summarise(act.steps.grouped, sum = sum(steps)) # computes sum of steps for each day.
```

## What is mean total number of steps taken per day?

This script plots a histogram of the total number of steps taken each day. The standard binwidth is around 700 steps. I rounded up to binwidth of 1000 because I felt it captured a little more visual info about the distribution.


```r
p.steps <- ggplot(data = act.steps.summary, aes(x = sum)) + 
    geom_histogram(binwidth = 1000, 
                   col = "blue", 
                   aes(fill = ..count..)) +
    scale_fill_gradient("Count", low = "brown", high = "orange") +
    labs(title = "Histogram for Steps Taken Each Day") +
    labs(x = "Steps Taken in One Day (Binwidth of 1000 Steps)", y = "Day Count") +
    xlim(c(0, 22000))
p.steps
```

![](PA1_template_files/figure-html/plot_hist-1.png) 

# 2. Calculate and report the **mean** and **median** total number of steps taken per day

The dplyr summarise() function computes these values to a new 2x1 data frame. [summarize() is also a valid spelling.]


```r
meanmedian.steps <- 
    summarise(act.steps.summary, 
              mean = mean(sum), 
              median = median(sum))
meanmedian.steps
```

```
## Source: local data frame [1 x 2]
## 
##       mean median
## 1 10766.19  10765
```
The computed mean is 10766.2 and the median is 10765.

## What is the average daily activity pattern?

This script plots a ggplot time series of the 5-minute-interval along the x-axis, and the average number of steps taken, averaged across all days, along the y-axis.


```r
act.interval.grouped <- group_by(act, interval) # enables analysis by interval
act.interval.summary <- summarise(act.interval.grouped, mean = mean(steps)) # computes mean of steps by interval
p.interval <- ggplot(data = act.interval.summary, aes(x = interval, y = mean)) +
    geom_line(color = "blue") +
    labs(title = "Time Series of Steps Averaged Across All Days per Interval") +
    labs(x = "Time Interval", y = "Average Steps")
p.interval
```

![](PA1_template_files/figure-html/plot_timeseries-1.png) 

# Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

To answer this question, I subset the summary created in the previous script to identify the maximum mean.


```r
max.steps <- subset(act.interval.summary, mean == max(act.interval.summary$mean))
max.steps
```

```
## Source: local data frame [1 x 2]
## 
##   interval     mean
## 1      835 206.1698
```
The maximum mean result from this data frame is 206.1698113, and it belongs to time interval #835.

## Imputing missing values

Earlier, I avoided handling NA steps values by filtering them from my file import. I now import from the file again to a new variable to include NAs. The number of NA rows is reported below the code chunk.


```r
act.with.na <- read.csv(datapath)
nrow(act.with.na[is.na(act.with.na$steps), ])
```

```
## [1] 2304
```

My strategy is to replace all 2304 NA steps with the mean of the corresponding interval. This mean was calculated earlier. The trick to replacing with the correct mean is matching between the two tables by interval. I must have read over thirty stackoverflow and r-bloggers pages, and still didn't find the solution I arrived at. I kept thinking that I'd have to resort to a for loop, or I an apply() family function. However, I found I could accomplish this by using the following functions:

1. mutate() can accomplish all of this in a single function call.
2. ifelse() is the middle term in mutate. 
+ IF steps value is NA, replace.
+ ELSE leave steps value as is.
3. As mutate works row by row, row_number() is the key to matching the current activity df row with the interval mean row from the other df. 


```r
act.steps.imputed <- mutate(act.with.na, steps = ifelse(is.na(steps),
    act.interval.summary$mean[
        act.interval.summary$interval == 
            act.with.na$interval[row_number()]], 
    steps))
```

The above script is complicated, so I want to explain my procedure in more detail.

1. The whole script is a single mutate() function replacing the NAs with corresponding means in a new data frame. 
2. I give mutate() the new df including NAs.
3. IF the steps variable in an observation is NA, replace. ELSE leave steps alone.
4. The replacement value comes from the earlier interval means df. 
5. I use data frame indices to match the interval mean to the current row_number() of the new df. This chunk of the function is confusing to read so here is a pseudocode rendition of that middle ifelse() term:

```
mean.df$mean[mean.df$interval == full.df$interval[row_number()]]
```

The next code chunk plots a histogram of the total number of steps taken each day.


```r
act.steps.imputed.grouped <- group_by(act.steps.imputed, date)
act.steps.imputed.summary <- summarise(act.steps.imputed.grouped, sum = sum(steps))

p.steps.imputed <- ggplot(data = act.steps.imputed.summary, aes(x = sum)) + 
    geom_histogram(binwidth = 2500, 
                   col = "blue", 
                   aes(fill = ..count..)) +
    scale_fill_gradient("Count", low = "brown", high = "orange") +
    labs(title = "Histogram for Steps Taken Each Day") +
    labs(x = "Steps Taken in One Day (Binwidth of 1000 Steps)", y = "Day Count") +
    xlim(c(0, 22000))
p.steps.imputed
```

![](PA1_template_files/figure-html/plot_NAhist-1.png) 
Next, we compute the new mean and median.


```r
meanmedian.steps.imputed <- 
    summarise(act.steps.imputed.summary, 
              mean = mean(sum, na.rm = TRUE), 
              median = median(sum, na.rm = TRUE))
meanmedian.steps.imputed
```

```
## Source: local data frame [1 x 2]
## 
##       mean   median
## 1 10766.19 10765.59
```

The updated mean is 10766.2 and the updated median is 10765.6. Compare this to the earlier mean of 10766.2 and median of 10765. The above histogram and this updated mean and median demonstrate the negligible impact of replacing NAs in the steps variable with interval means. 

Now we explore differences in activity patterns between weekdays and weekends. First, I use the weekdays() function and mutate() to add a new variable to my data frame, a 2-level factor that classifies each date as either "Weekend" or "Weekday".


```r
act.steps.imputed.grouped$day <- weekdays(as.Date(act.steps.imputed.grouped$date))
act.steps.imputed.grouped <- 
    mutate(act.steps.imputed.grouped, 
           day = ifelse(day == "Saturday" || day == "Sunday", "Weekend", "Weekday"))
act.steps.imputed.grouped$day <- as.factor(act.steps.imputed.grouped$day)
```

Next, I use ggplot2 facets to make a panel time series comparing the 5-minute interval (x-axis) and the average number of steps taken (y-axis), between Weekdays and Weekends. The plot shows more stepping, on average, on the weekend.


```r
asig.day <- group_by(act.steps.imputed.grouped, interval, day)
asig.day.summary <- summarise(asig.day, meansteps = mean(steps, na.rm = TRUE))
    # abbreviating variable name act.steps.imputed.grouped as "asig"
    # to keep my growing variable names from getting out of hand.

p.day <- ggplot(data = asig.day.summary, aes(x = interval, y = meansteps)) +
    geom_line(color = "blue") +
    labs(title = "Time Series of Steps Averaged Across All Days per Interval") +
    labs(x = "Time Interval", y = "Average Steps") +
    facet_grid(day ~ .)
p.day
```

![](PA1_template_files/figure-html/plot_weekdays-1.png) 

Finito. Let's remember to clean up.


```r
# good housekeeping!
detach(package:dplyr, unload = TRUE)
detach(package:ggplot2, unload = TRUE)
```
