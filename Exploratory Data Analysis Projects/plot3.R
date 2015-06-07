plot3 <- function() {
    
    # IMPORTANT: first step is to run the explore_power() function, which is
    # responsible for extracting Feb1-Feb2 2007 data from the big
    # household_power_consumption.txt file. 
    # The result of that function call is a file and a small data frame.
    # All plotN.R scripts run this at the beginning to avoid the problem of
    # missing data.
    
    source('Exploratory Data Analysis Projects/explore_power.R')
    powerdf <- explore_power()
    
    png(filename = "Exploratory Data Analysis Projects/plot3.png", width = 480, height = 480)
    plot(powerdf$DateTime, powerdf$Sub_metering_1, axes = TRUE, type = "l", xlab = "", ylab = "Energy sub metering")
    par(new=T)
    plot(powerdf$DateTime, powerdf$Sub_metering_2, ylim = c(0,30), axes = FALSE, type = "l", col = "red", xlab = "", ylab = "Energy sub metering")
    par(new=T)
    plot(powerdf$DateTime, powerdf$Sub_metering_3, ylim = c(0,30), axes = FALSE, type = "l", col = "blue", xlab = "", ylab = "Energy sub metering")
    legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
    dev.off()
    
}