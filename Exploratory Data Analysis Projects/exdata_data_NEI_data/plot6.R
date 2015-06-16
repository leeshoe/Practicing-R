plot6 <- function() {
    
    ### Purpose is to answer the question:
        # Compare emissions from motor vehicle sources in Baltimore City with
        # emissions from motor vehicle sources in Los Angeles County, 
        # California (fips == 06037). Which city has seen greater changes over 
        # time in motor vehicle emissions? 
    
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
        # We only want motor vehicle sources, so we look to the SCC df. 
        # EI.Sector variable has several values that begin with "Mobile".
        # They all seem to be "motor vehicles". No other values seem to be
        # "motor vehicles", so we'll grep for 'mobile'.
    SCC.mv <- filter(SCC, grepl("mobile", SCC$EI.Sector, ignore.case = TRUE))
    NEI.mv <- filter(NEI, SCC %in% SCC.mv$SCC)
    
        # Subset aka filter() Baltimore rows, fips == 24510,
        # OR LA rows, fips == 06037
        # Then, we only need Emissions and year variables, grouped by each of four years.
    NEI.mv.baltimore.la <- filter(NEI.mv, fips == "24510" | fips == "06037")
    NEI.mv.baltimore.la.grouped <- NEI.mv.baltimore.la %>% group_by(fips, year) %>% select(fips, Emissions, year)
        # Then summarize sums Emissions within each group defined by group_by(year)
    NEI.mv.baltimore.la.emission.sums <- summarize(NEI.mv.baltimore.la.grouped, TotalEmissions = sum(Emissions))
    
        # This is just for clear labelling of my facets in the plot.
    NEI.mv.baltimore.la.emission.sums[NEI.mv.baltimore.la.emission.sums == "24510"] <- "Baltimore City"
    NEI.mv.baltimore.la.emission.sums[NEI.mv.baltimore.la.emission.sums == "06037"] <- "Los Angeles County"
    
    # Step 3: Draw the plot to png. 
    
    p <- qplot(year, TotalEmissions, data = NEI.mv.baltimore.la.emission.sums, 
               geom = c("line", "point"), facets = . ~ fips,
               xlab = "year", ylab = "Motor Vehicle PM2.5 Emissions (tons)")
    p + geom_line(size = 2) + geom_point(size = 3)
    ggsave(filename = "Exploratory Data Analysis Projects/exdata_data_NEI_data/plot6.png",
           width = 4.8, height = 4.8, units = "in", dpi = 100)
    
    # no need to close device.
    # dev.off()
    
}