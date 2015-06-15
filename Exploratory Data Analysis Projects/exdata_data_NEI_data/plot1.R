# Step 1: just noodlin' around, exploring my new DFs
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Exploratory Data Analysis Projects/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("Exploratory Data Analysis Projects/exdata_data_NEI_data/Source_Classification_Code.rds")
# object_size(NEI)
# 680 MB
# object_size(SCC)
# 3.74 MB

plot1 <- NEI[c("Emissions", "year")]
plot1$year <- as.factor(plot1$year)
# Next step: split, use lapply to sum the Emissions, then there's 4 to plot?
plot1 <- split(plot1, as.factor(plot1$year))