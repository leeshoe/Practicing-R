plot4 <- function() {
    
    ### Purpose is to answer the question:
    # Across the United States, how have emissions from coal combustion-
    # related sources changed from 1999–2008?
    
    library(dplyr)
    
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
        # We only want coal sources, so we look to the SCC df. 
        # EI.Sector variable has coal in the text, so using grep to filter rows from NEI.
    SCC.coal <- filter(SCC, grepl("coal", SCC$EI.Sector, ignore.case = TRUE))
    NEI.coal <- filter(NEI, SCC %in% SCC.coal$SCC)
    NEI.coal.grouped <- NEI.coal %>% group_by(year) %>% select(Emissions, year)
    # Then summarize sums Emissions within each group defined by group_by(year)
    NEI.coal.emission.sums <- summarize(NEI.coal.grouped, TotalEmissions = sum(Emissions))
    
    # Step 3: Draw the plot to png. 
    
    p <- qplot(year, TotalEmissions, data = NEI.coal.emission.sums, 
               geom = "segment", xend = year, yend = 0, size = I(2),
               xlab = "year", ylab = "Total Coal-related PM2.5 Emissions (tons)")
    p + geom_line(size = 2)
    ggsave(filename = "Exploratory Data Analysis Projects/exdata_data_NEI_data/plot4.png",
           width = 4.8, height = 4.8, units = "in", dpi = 100)
    
    # no need to close device.
    # dev.off()
    
}