---
title: "README"
author: "Tim Shores"
date: "July 27, 2015"
output: html_document
---

# Introduction

This repo is my project for the following Coursera/Johns Hopkins assignment. I finished to spec, but I'd like to revisit the final report because I'm not fully satisfied with my plots and my data scrubbing. I would prefer to see the total count of harm and damage in its own graph, with means in a separate plot. The top most harmful and damaging storm event type could be scatter plotted, or perhaps plotted in a time series. I'd also like to reformat numbers as currency. The EVTYPE variable is full of duplication and typos -- "tornados", "tornadoes", and "tornedoes" should obviously all be accounted for as one type of storm event. I admire the work of the following students:
* http://rpubs.com/sigrist/97287
* https://rpubs.com/anammari/StormDataAnalysis

Storms and other severe weather events can cause both public health and economic problems for communities and municipalities. Many severe events can result in fatalities, injuries, and property damage, and preventing such outcomes to the extent possible is a key concern.

This project involves exploring the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database. This database tracks characteristics of major storms and weather events in the United States, including when and where they occur, as well as estimates of any fatalities, injuries, and property damage.

# Data

The data for this assignment come in the form of a comma-separated-value file compressed via the bzip2 algorithm to reduce its size. You can download the file from the course web site:

* [Storm Data (47Mb)](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2)

There is also some documentation of the database available. Here you will find how some of the variables are constructed/defined.

* National Weather Service [Storm Data Documentation](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf)
* National Climatic Data Center [Storm Events FAQ](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20Events-FAQ%20Page.pdf)

The events in the database start in the year 1950 and end in November 2011. In the earlier years of the database there are generally fewer events recorded, most likely due to a lack of good records. More recent years should be considered more complete.
Assignment

The basic goal of this assignment is to explore the NOAA Storm Database and answer some basic questions about severe weather events. You must use the database to answer the questions below and show the code for your entire analysis. Your analysis can consist of tables, figures, or other summaries. You may use any R package you want to support your analysis.
Questions

Your data analysis must address the following questions:

1. Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?
2. Across the United States, which types of events have the greatest economic consequences?

Consider writing your report as if it were to be read by a government or municipal manager who might be responsible for preparing for severe weather events and will need to prioritize resources for different types of events. However, there is no need to make any specific recommendations in your report.
Requirements

For this assignment you will need some specific tools

1. RStudio: You will need RStudio to publish your completed analysis document to RPubs. You can also use RStudio to edit/write your analysis.
2. knitr: You will need the knitr package in order to compile your R Markdown document and convert it to HTML

# Document Layout

1. Language: Your document should be written in English.
2. Title: Your document should have a title that briefly summarizes your data analysis
3. Synopsis: Immediately after the title, there should be a synopsis which describes and summarizes your analysis in at most 10 complete sentences.
4. There should be a section titled Data Processing which describes (in words and code) how the data were loaded into R and processed for analysis. In particular, your analysis must start from the raw CSV file containing the data. You cannot do any preprocessing outside the document. If preprocessing is time-consuming you may consider using the cache = TRUE option for certain code chunks.
5. There should be a section titled Results in which your results are presented.
6. You may have other sections in your analysis, but Data Processing and Results are required.
7. The analysis document must have at least one figure containing a plot.
8. Your analyis must have no more than three figures. Figures may have multiple plots in them (i.e. panel plots), but there cannot be more than three figures total.
9. You must show all your code for the work in your analysis document. This may make the document a bit verbose, but that is okay. In general, you should ensure that echo = TRUE for every code chunk (this is the default setting in knitr).

# Publishing Your Analysis

For this assignment you will need to publish your analysis on RPubs.com. If you do not already have an account, then you will have to create a new account. After you have completed writing your analysis in RStudio, you can publish it to RPubs by doing the following:

* In RStudio, make sure your R Markdown document (.Rmd) document is loaded in the editor
* Click the Knit HTML button in the doc toolbar to preview your document.
* In the preview window, click the Publish button.

Once your document is published to RPubs, you should get a unique URL to that document. Make a note of this URL as you will need it to submit your assignment.

NOTE: If you are having trouble connecting with RPubs due to proxy-related or other issues, you can upload your final analysis document file as a PDF to Coursera instead.
Submitting Your Assignment

In order to submit this assignment, you must copy the RPubs URL for your completed data analysis document in to the peer assessment question.