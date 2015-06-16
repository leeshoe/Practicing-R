plot5 <- function() {
    
    ### Purpose is to answer the question:
        # How have emissions from motor vehicle sources changed from 
        # 1999–2008 in Baltimore City? 
    
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
    
        # Subset aka filter() Baltimore rows, fips == 24510
        # Then, we only need Emissions and year variables, grouped by each of four years.
    NEI.mv.baltimore <- filter(NEI.mv, fips == 24510)
    NEI.mv.baltimore.grouped <- NEI.mv.baltimore %>% group_by(year) %>% select(Emissions, year)
        # Then summarize sums Emissions within each group defined by group_by(year)
    NEI.mv.baltimore.emission.sums <- summarize(NEI.mv.baltimore.grouped, TotalEmissions = sum(Emissions))
    
    # Step 3: Draw the plot to png. 
    
    p <- qplot(year, TotalEmissions, data = NEI.mv.baltimore.emission.sums, 
               geom = c("line", "point"),
               xlab = "year", ylab = "Baltimore, MD Motor Vehicle PM2.5 Emissions (tons)")
    p + geom_line(size = 2) + geom_point(size = 3)
    ggsave(filename = "Exploratory Data Analysis Projects/exdata_data_NEI_data/plot5.png",
           width = 4.8, height = 4.8, units = "in", dpi = 100)
    
    # no need to close device.
    # dev.off()
    
}