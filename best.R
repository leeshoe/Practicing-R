best <- function(state, outcome) {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
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
        lowest_rate <- min(state_subset_available[,outcome_subset_number])
        lowest_rate_hospitals <- state_subset_available[state_subset_available[,outcome_subset_number] == lowest_rate,]$Hospital.Name
        min(sort(lowest_rate_hospitals))

    } else {
        
        stop("invalid outcome")
    
    }
}