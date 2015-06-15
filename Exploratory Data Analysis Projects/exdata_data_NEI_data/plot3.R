plot3 <- function() {
    
    ### Purpose is to answer the question:
        # Of the four types of sources indicated by the type 
        # (point, nonpoint, onroad, nonroad) variable, which of these 
        # four sources have seen decreases in emissions from 1999–2008 
        # for Baltimore City? Which have seen increases in emissions 
        # from 1999–2008? 
        # Use the ggplot2 plotting system to make a plot answer this question.
    
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
    NEI.baltimore.grouped <- NEI.baltimore %>% group_by(type, year) %>% select(Emissions, type, year)
        # Then summarize sums Emissions within each group defined by group_by(year)
    NEI.baltimore.emission.sums <- summarize(NEI.baltimore.grouped, TotalEmissions = sum(Emissions))
    
    # Step 3: Draw the plot to png. 
    
    p <- qplot(year, TotalEmissions, data = NEI.baltimore.emission.sums, 
          color = type, geom = c("line", "point"),
          xlab = "year", ylab = "Baltimore, MD Total PM2.5 Emissions (tons)")
    p + geom_line(size = 3) + geom_point(size = 5)
    ggsave(filename = "Exploratory Data Analysis Projects/exdata_data_NEI_data/plot3.png")
    
        # close the PNG device (opened by ggsave(), it chooses device according to filename.
    dev.off()
    
}