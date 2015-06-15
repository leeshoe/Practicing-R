plot2 <- function() {
    
    ### Purpose is to answer the question:
        # Have total emissions from PM2.5 decreased in the Baltimore City, 
        # Maryland (fips == 24510) from 1999 to 2008? Use the base plotting 
        # system to make a plot answering this question.
    
    # Step 1: acquire data.
    # This first line will likely take a few seconds. Be patient!
    
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
    
    # Step 2: transform data relevant to the question.
        # Subset aka filter() Baltimore rows, fips == 24510
        # Then, we only need Emissions and year variables, grouped by each of four years.
    NEI.baltimore <- filter(NEI, fips == 24510)
    NEI.baltimore.grouped <- NEI.baltimore %>% group_by(year) %>% select(Emissions, year)
        # Then summarize sums Emissions within each group defined by group_by(year)
    NEI.baltimore.emission.sums <- summarize(NEI.baltimore.grouped, TotalEmissions = sum(Emissions))
    
    # Step 3: Draw the plot to png. 
    png(filename = "Exploratory Data Analysis Projects/exdata_data_NEI_data/plot2.png", width = 480, height = 480)
    
    # I chose to make a histogram-like plot with ticks only for years with data.
    plot(NEI.baltimore.emission.sums$year, NEI.baltimore.emission.sums$TotalEmissions, 
         xlab = "Year", ylab = "Baltimore, MD Total PM2.5 Emissions (tons)", 
         xaxt = "n", type = "h", col = "blue", lwd = 20, lend = 2)
    axis(1, at = NEI.baltimore.emission.sums$year) 
    
    # close the PNG device.
    dev.off()
    
}