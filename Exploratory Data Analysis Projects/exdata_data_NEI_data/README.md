---
title: "README.md"
author: "Tim Shores"
date: "June 21, 2015 -- Merry Solstice!"
output: html_document
---

<body dir="ltr" style="max-width:8.5in;margin-top:0.7874in; margin-bottom:0.7874in; margin-left:0.7874in; margin-right:0.7874in; writing-mode:lr-tb; ">

<div class="Sect1" id="evaluatedGroup-f5ff7c3e71d8f4ff">
<h2 class="Heading_20_2"><span/>Description of Results</h2>
<p class="Text_20_body">This repo contains my solutions to the second project in Coursera's Exploratory Data Analysis class. The project is described below, including links to source data. The task is to explore the NEI emissions data with R scripts that produce plots to answer six questions. My scripts and the PNG file plots they produce are in this repo, and they will reproduce my results from the source data. The questions, and my basic findings, are:</p>
<ol>
<li>Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.</li>
<ul>
<li>plot1.png shows that total emissions from PM2.5 HAVE decreased.</li>
</ul>
<li>Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008? Use the base plotting system to make a plot answering this question.</li>
<ul>
<li>plot2.png shows Baltimore PM2.5 emissions have decreased but not as quickly as all locations, due to an increase in 2005.</li>
</ul>
<li>Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.</li>
<ul>
<li>plot3.png shows POINT type increases slightly, seeing a sharp increase from 1999 to 2005, then a sharp decrease. Other types see decrease.</li>
</ul>
<li>Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?</li>
<ul>
<li>plot4.png shows they begin to decline after 2005.</li>
</ul>
<li>How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?</li>
<ul>
<li>plot5.png they go down and then start rising again.</li>
</ul>
<li>Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?</li>
<ul>
<li>Since the question is of greater change, I interpreted this to mean the deviation from a normalized starting point of 1999 for both locations. These plots together in plot6.png show two types of data:</li>
<ol>
<li>The top plots show simple emissions changes, just like the previous plots.</li>
<li>The bottom two plots show the calculated percent of change from the 1999 starting point, as an absolute value for the purposes of comparison. (Since Baltimore City's emissions go down its percent of change is actually negative.)</li>
</ol>
<li>The calculated percentage reveals that Baltimore City has seen greater change.</li>
</ul>
</ol>

<h2 class="Heading_20_2"><a id="a__Introduction"><span/></a>Introduction: Project Description</h2>
<p class="Text_20_body">Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the <a href="http://www.epa.gov/ttn/chief/eiinformation.html">EPA National Emissions Inventory web site</a>.</p>
<p class="Text_20_body">For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.</p>
<h2 class="Heading_20_2"><a id="a__Data"><span/></a>Data</h2>
<p class="Text_20_body">The data for this assignment are available from the course web site as a single zip file:</p>
<ul>
<li>
<p class="P1" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span><a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip">Data for Peer Assessment</a> [29Mb] <span class="odfLiEnd"/> </p>
</li>
</ul>
<p class="Text_20_body">The zip file contains two files:</p>
<p class="Text_20_body">PM2.5 Emissions Data (<span class="Source_20_Text">summarySCC_PM25.rds</span>): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of <span class="T1">tons</span> of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.</p>
<code>
<p>##     fips      SCC Pollutant Emissions  type year</p>
<p>## 4  09001 10100401  PM25-PRI    15.714 POINT 1999</p>
<p>## 8  09001 10100404  PM25-PRI   234.178 POINT 1999</p>
<p>## 12 09001 10100501  PM25-PRI     0.128 POINT 1999</p>
<p>## 16 09001 10200401  PM25-PRI     2.036 POINT 1999</p>
<p>## 20 09001 10200504  PM25-PRI     0.388 POINT 1999</p>
<p>## 24 09001 10200602  PM25-PRI     1.490 POINT 1999</p>
</code>
<ul>
<li>
<p class="P2" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span><span class="Source_20_Text">fips</span>: A five-digit number (represented as a string) indicating the U.S. county <span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P2" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span><span class="Source_20_Text">SCC</span>: The name of the source as indicated by a digit string (see source code classification table)<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P2" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span><span class="Source_20_Text">Pollutant</span>: A string indicating the pollutant<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P2" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span><span class="Source_20_Text">Emissions</span>: Amount of PM2.5 emitted, in tons<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P2" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span><span class="Source_20_Text">type</span>: The type of source (point, non-point, on-road, or non-road)<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P2" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span><span class="Source_20_Text">year</span>: The year of emissions recorded<span class="odfLiEnd"/> </p>
</li>
</ul>
<p class="Text_20_body">Source Classification Code Table (<span class="Source_20_Text">Source_Classification_Code.rds</span>): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.</p>
<p class="Text_20_body">You can read each of the two files using the <span class="Source_20_Text">readRDS()</span> function in R. For example, reading in each file can be done with the following code:</p>
<code><p>## This first line will likely take a few seconds. Be patient!</p>
<p>NEI &lt;- readRDS("summarySCC_PM25.rds")</p>
<p>SCC &lt;- readRDS("Source_Classification_Code.rds")</p></code>
<p class="Text_20_body">as long as each of those files is in your current working directory (check by calling <span class="Source_20_Text">dir()</span> and see if those files are in the listing).</p>
<h2 class="Heading_20_2"><a id="a__Assignment"><span/></a>Assignment</h2>
<p class="Text_20_body">The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.</p>
<h3 class="Heading_20_3"><a id="a__Questions"><span/></a>Questions</h3>
<p class="Text_20_body">You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.</p>
<ol>
<li>
<p class="P3" style="margin-left:0.748cm;"><span class="Numbering_20_Symbols" style="display:block;float:left;min-width:0.4991cm;">1.</span>Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the <span class="T1">base</span> plotting system, make a plot showing the <span class="T2">total</span> PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P3" style="margin-left:0.748cm;"><span class="Numbering_20_Symbols" style="display:block;float:left;min-width:0.4991cm;">2.</span>Have total emissions from PM2.5 decreased in the <span class="T1">Baltimore City</span>, Maryland (<span class="Source_20_Text">fips == "24510"</span>) from 1999 to 2008? Use the <span class="T1">base</span> plotting system to make a plot answering this question.<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P3" style="margin-left:0.748cm;"><span class="Numbering_20_Symbols" style="display:block;float:left;min-width:0.4991cm;">3.</span>Of the four types of sources indicated by the <span class="Source_20_Text">type</span> (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for <span class="T1">Baltimore City</span>? Which have seen increases in emissions from 1999–2008? Use the <span class="T1">ggplot2</span> plotting system to make a plot answer this question.<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P3" style="margin-left:0.748cm;"><span class="Numbering_20_Symbols" style="display:block;float:left;min-width:0.4991cm;">4.</span>Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P3" style="margin-left:0.748cm;"><span class="Numbering_20_Symbols" style="display:block;float:left;min-width:0.4991cm;">5.</span>How have emissions from motor vehicle sources changed from 1999–2008 in <span class="T1">Baltimore City</span>? <span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P3" style="margin-left:0.748cm;"><span class="Numbering_20_Symbols" style="display:block;float:left;min-width:0.4991cm;">6.</span>Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in <span class="T1">Los Angeles County</span>, California (<span class="Source_20_Text">fips == "06037"</span>). Which city has seen greater changes over time in motor vehicle emissions?<span class="odfLiEnd"/> </p>
</li>
</ol>
<h3 class="Heading_20_3"><a id="a__Making_and_Submitting_Plots"><span/></a>Making and Submitting Plots</h3>
<p class="Text_20_body">For each plot you should</p>
<ul>
<li>
<p class="P4" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span>Construct the plot and save it to a <span class="T1">PNG file</span>.<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P4" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span>Create a separate R code file (<span class="Source_20_Text">plot1.R</span>, <span class="Source_20_Text">plot2.R</span>, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file. Only include the code for a single plot (i.e. <span class="Source_20_Text">plot1.R</span> should only include code for producing <span class="Source_20_Text">plot1.png</span>)<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P4" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span>Upload the PNG file on the Assignment submission page<span class="odfLiEnd"/> </p>
</li>
<li>
<p class="P4" style="margin-left:0.748cm;"><span class="Bullet_20_Symbols" style="display:block;float:left;min-width:0.4991cm;"></span>Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.<span class="odfLiEnd"/> </p>
</li>
</ul>
</div>
<p class="Standard"> </p>
</body>
</html>