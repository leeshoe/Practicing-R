rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    if(outcome == "heart attack" || outcome == "heart failure" || outcome == "pneumonia") {
        
        fulldata <- 
            read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
        outcome_subset_number <- switch(outcome, "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        outcome_name <- colnames(fulldata[outcome_subset_number])
        slicedata <- fulldata[c("Hospital.Name", "State", outcome_name)]
        available_slice <- available_slice <- slicedata[slicedata[outcome_name] != "Not Available",]
        
        available_slice <- switch(outcome,
                                  "heart attack" = transform(available_slice, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),
                                  "heart failure" = transform(available_slice, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),
                                  "pneumonia" = transform(available_slice, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)))
                                  
        # syntax is correct, but how to interpret the variable???
        
        split_by_state <- split(available_slice, available_slice$State)
        ordered_by_outcome <- lapply(split_by_state, function(df) df[order(df[3], df$Hospital.Name),])
        
        
        if(num == "best") {
            
            resulting_hospitals <- lapply(ordered_by_outcome, function(df) df$Hospital.Name[1])
        
        } else if (num == "worst") {
            
            resulting_hospitals <- lapply(ordered_by_outcome, function(df) tail(df$Hospital.Name, n=1))
            
        } else if (is.numeric(num)) {
            
            resulting_hospitals <- lapply(ordered_by_outcome, function(df) df$Hospital.Name[num])
            # "head" test works but two "tails" don't... problem with ordering? or with max()?
            # min and max are strictly alphabetical! maybe these FUNS are wrong... try index instead.
        }
  
        resulting_df <- data.frame(hospital = unlist(resulting_hospitals), state = rep(names(resulting_hospitals), lapply(resulting_hospitals, length)))
        return(resulting_df)
        
    } else {
        
        stop("invalid outcome")
        
    }
}