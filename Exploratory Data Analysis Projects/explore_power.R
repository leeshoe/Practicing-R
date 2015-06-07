explore_power <- function() {
    
    library(lubridate) # used for parsing time, second column of input file
    library(plyr) # used for mutate, creating new datetime column
    
    ### STEP 1 Importing data, skip if exists. This uses a loop to import only
    ### the data we need.
    
    if(!dir.exists("Exploratory Data Analysis Projects")) {
        dir.create("Exploratory Data Analysis Projects")
        stop("Copy the file household_power_consumption.txt to the new Exploratory Data Analysis Projects subdirectory of your working directory.")
    }
    
    if(!file.exists("Exploratory Data Analysis Projects/household_power_consumption.txt")) {
        stop("The file household_power_consumption.txt is missing from the Exploratory Data Analysis Projects subdirectory of your working directory.")
    }
    
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
    
    return(powerdf)
    
}