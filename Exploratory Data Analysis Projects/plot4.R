plot4 <- function() {
    
    # IMPORTANT: first step is to run the explore_power() function, which is
    # responsible for extracting Feb1-Feb2 2007 data from the big
    # household_power_consumption.txt file. 
    # The result of that function call is a file and a small data frame.
    # All plotN.R scripts run this at the beginning to avoid the problem of
    # missing data.
    
    source('Exploratory Data Analysis Projects/explore_power.R')
    powerdf <- explore_power()
    
    png(filename = "Exploratory Data Analysis Projects/plot4.png", width = 480, height = 480)
    
        # par() allocates a 2x2 grid for our four base plots
    par(mfrow = c(2, 2)) 
    
    # Next: create all four plots in one big with() function call.
    # I don't call my other scripts explicitly, because they're coded to output
    # only to file. In a future version, this could be accomplished by passing args.
    with(powerdf, {
        
            #plot2 recreated in top left
        plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

            #new plot in top right, Voltage by date time
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
            
            #plot3 recreated at bottom left
        plot(DateTime, Sub_metering_1, axes = TRUE, type = "l", xlab = "", ylab = "Energy sub metering")
        par(new=T)
        plot(DateTime, Sub_metering_2, ylim = c(0,30), axes = FALSE, type = "l", col = "red", xlab = "", ylab = "Energy sub metering")
        par(new=T)
        plot(DateTime, Sub_metering_3, ylim = c(0,30), axes = FALSE, type = "l", col = "blue", xlab = "", ylab = "Energy sub metering")
        legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n")
        
            # new plot in bottom right, Global_reactive_power by date time
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
        
        })

    dev.off()
    
}
