explore_power <- function() {

    library(lubridate) # used for parsing time, second column of input file
    library(plyr) # used for mutate, creating new datetime column

    ### STEP 1 Importing data, skip if exists. This uses a loop to import only
    ### the data we need.
    infilePath <- "Exploratory Data Analysis Projects/household_power_consumption.txt"
    outfilePath <- "Exploratory Data Analysis Projects/household_power_consumption_FEB1-FEB2-2007.txt"

    if(!file.exists(outfilePath)) {
        message("Slicing rows from input dated Feb 1 2007 to Feb 2 2007. Output to file ./Exploratory Data Analysis Projects/household_power_consumption_FEB1-FEB2-2007.txt ... This will take a few minutes.")
        infileHandle <- file(infilePath, "r")
        outfileHandle <- file(outfilePath,"a")
        line <- readLines(infileHandle, n=1)
        cat(line, file = outfileHandle, append = TRUE, sep = "\n") # write header row to file.
        line <- readLines(infileHandle, n=1) # advance to first data row (second row of file)
            # We will only be using data from the dates 2007-02-01 and 2007-02-02.
        earliest <- as.Date("1/2/2007", "%d/%m/%Y")
        latest <- as.Date("2/2/2007", "%d/%m/%Y")
            # These two variables set those dates as parameters, with dates formatted
            # to match first column from input file.
        while(length(line)) {
            line.split <- strsplit(line, ';') # splitting one line to parse date from first column
            if(length(line.split[[1]]) > 1) {
                currentDate <- as.Date(line.split[[1]][1], "%d/%m/%Y") # date format matches earliest/latest
                if(currentDate >= earliest & currentDate <= latest) {
                    cat(line, file = outfileHandle, append = TRUE, sep = "\n")
                    # append to file only if within earliest/latest data parameters
                }
            }
            line <- readLines(infileHandle, n=1) # advance to next line and repeat.
        }
        
        # good housekeeping:
        close(infileHandle)
        close(outfileHandle)
        
    } else {
        message("Output file already exists: ./Exploratory Data Analysis Projects/household_power_consumption_FEB1-FEB2-2007.txt")
    }
    
    ### STEP 2: Cleaning data.
        # In read.csv2(), the dec argument interprets number variables as numeric rather 
        # than factors. This is because read.csv/read.csv2 set dec = ",".
    powerdf <- read.csv2(
        "Exploratory Data Analysis Projects/household_power_consumption_FEB1-FEB2-2007.txt", 
        header = TRUE, dec = ".") 
        # Need to explicitly cast Date variable. This is not necessary with Time column.
    powerdf$Date <- as.Date(powerdf$Date, "%d/%m/%Y")
        # Next: mutate() creates a new variable DateTime, combines Date and Time columns together,
        # recasts as POSIX for easier parsing. as.POSIXct recognizes Time format without casting.
    powerdf <- mutate(powerdf, DateTime=(as.POSIXct(paste(powerdf$Date, powerdf$Time))))
        # Then reorder columns, get rid of redundant Date and Time variables.
    powerdf <- powerdf[ , c(10,3:9)]
    
    ### STEP 3: The four plots.
    ### I'll break each of these out to separate code files after exploring code.
        
        # plot1.R, plot1.png
    png(filename = "Exploratory Data Analysis Projects/plot1.png", width = 480, height = 480)
    hist(powerdf$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
    dev.off()
    
        # plot2.R, plot2.png
    png(filename = "Exploratory Data Analysis Projects/plot2.png", width = 480, height = 480)
    plot(powerdf$DateTime, powerdf$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    dev.off()
    
        # plot3.R, plot3.png
    png(filename = "Exploratory Data Analysis Projects/plot3.png", width = 480, height = 480)
    plot(powerdf$DateTime, powerdf$Sub_metering_1, axes = TRUE, type = "l", xlab = "", ylab = "Energy sub metering")
    par(new=T)
    plot(powerdf$DateTime, powerdf$Sub_metering_2, ylim = c(0,30), axes = FALSE, type = "l", col = "red", xlab = "", ylab = "Energy sub metering")
    par(new=T)
    plot(powerdf$DateTime, powerdf$Sub_metering_3, ylim = c(0,30), axes = FALSE, type = "l", col = "blue", xlab = "", ylab = "Energy sub metering")
    legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
    dev.off()
    
        # plot4.R, plot4.png
    png(filename = "Exploratory Data Analysis Projects/plot4.png", width = 480, height = 480)
    
    par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
    with(powerdf, {
        #plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot1()
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        plot3()
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
        mtext("Ozone and Weather in New York City", outer = TRUE)
    })
    
    
    dev.off()
    
}