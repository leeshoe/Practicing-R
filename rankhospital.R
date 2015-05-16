rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    
    # outer if test is input validation of possible outcomes.
    if(outcome == "heart attack" || outcome == "heart failure" || outcome == "pneumonia") {
        
        fulldata <- 
            read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
        
        state_subset <- subset(fulldata, State == state)
        
        if(!(state %in% state_subset$State)) { # this is input validation of possible states.
            stop("invalid state")
        }
        
        outcome_subset_number <- switch(outcome, "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        state_subset_available <- state_subset[state_subset[[outcome_subset_number]] != "Not Available",]
        state_subset_available[,outcome_subset_number] <- as.numeric(state_subset_available[,outcome_subset_number])
        
        if(num == "best") {
            
            lowest_rate <- min(state_subset_available[,outcome_subset_number])
            lowest_rate_hospitals <- state_subset_available[state_subset_available[,outcome_subset_number] == lowest_rate,]$Hospital.Name
            return(min(sort(lowest_rate_hospitals)))
        
        } else if(num == "worst") {
            
            highest_rate <- max(state_subset_available[,outcome_subset_number])
            highest_rate_hospitals <- state_subset_available[state_subset_available[,outcome_subset_number] == highest_rate,]$Hospital.Name
            return(min(sort(highest_rate_hospitals)))
            
        } else if(is.numeric(num) && num <= nrow(state_subset_available)) {
            
            ordered_subset <- order(state_subset_available[,outcome_subset_number], state_subset_available$Hospital.Name)
            return(state_subset_available$Hospital.Name[ordered_subset][[num]])
            
        } else { return(NA) }
        
    } else {
        
        stop("invalid outcome")
        
    }
}
