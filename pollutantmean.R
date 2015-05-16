pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)

  monitor_data <- data.frame()
  for(i in 1:length(id)) {
    partial_data <- read.csv(as.character(paste0(sprintf("%s/%03d", directory,id[i]),".csv")))
    monitor_data <- rbind(monitor_data, partial_data)
  }
  
    return(mean(monitor_data[[pollutant]], na.rm=TRUE))
}