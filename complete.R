complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases

  complete_data <- data.frame()
  
  for(i in 1:length(id)) {
    current_file <- read.csv(as.character(paste0(sprintf("%s/%03d", directory,id[i]),".csv")))
    current_count <- c(id[i], sum(complete.cases(current_file)))
    complete_data <- rbind(complete_data, current_count)
  }
  
  colnames(complete_data) <- c("id", "nobs")
  
  return(complete_data)

}