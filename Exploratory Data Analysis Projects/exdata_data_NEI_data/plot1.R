plot1 <- function() {

    ### Purpose is to answer the question:
        # Have total emissions from PM2.5 decreased in the United States 
        # from 1999 to 2008? Using the base plotting system, make a plot 
        # showing the total PM2.5 emission from all sources for each of 
        # the years 1999, 2002, 2005, and 2008. 
    
    library(dplyr)
    
    ## This first line will likely take a few seconds. Be patient!
    
    if(!exists("NEI")) {
        NEI <- readRDS("Exploratory Data Analysis Projects/exdata_data_NEI_data/summarySCC_PM25.rds")
        # if() just to save time. 
    }
    
        # SCC is a much smaller df so I don't wrap with an if()
    SCC <- readRDS("Exploratory Data Analysis Projects/exdata_data_NEI_data/Source_Classification_Code.rds")
    
    # Info about these big ol' dataframes:
    # object_size(NEI)
    # 680 MB
    # object_size(SCC)
    # 3.74 MB   

        # We only need Emissions and year variables, grouped by each of four years. 
    NEI.grouped <- NEI %>% group_by(year) %>% select(Emissions, year)
        # Then summarize sums Emissions within each group defined by group_by(year)
    NEI.emission.sums <- summarize(NEI.grouped, TotalEmissions = sum(Emissions))
    
        # Draw the plot to png. 
    png(filename = "Exploratory Data Analysis Projects/exdata_data_NEI_data/plot1.png", width = 480, height = 480)

        # I chose to make a histogram-like plot with ticks only for years with data.
    plot(NEI.emission.sums$year, NEI.emission.sums$TotalEmissions, 
         xlab = "Year", ylab = "Total PM2.5 Emissions (tons)", 
         xaxt = "n", type = "h", col = "blue", lwd = 20, lend = 2)
        axis(1, at = NEI.emission.sums$year) 
        
        # close the PNG device.
    dev.off()
    
}