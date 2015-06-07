plot1 <- function() {
    
    # IMPORTANT: first step is to run the explore_power() function, which is
    # responsible for extracting Feb1-Feb2 2007 data from the big
    # household_power_consumption.txt file. 
    # The result of that function call is a file and a small data frame.
    # All plotN.R scripts run this at the beginning to avoid the problem of
    # missing data.
    
    source('Exploratory Data Analysis Projects/explore_power.R')
    powerdf <- explore_power()
    
    png(filename = "Exploratory Data Analysis Projects/plot1.png", width = 480, height = 480)
    hist(powerdf$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
    dev.off()
    
}