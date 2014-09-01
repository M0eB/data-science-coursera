


rankall <- function(outcome, num = "best") {
      
      ## Read outcome data
      data <- read.csv("outcome-of-care-measures.csv", na.strings=c("Not Available"))
      
      ## Check that outcome is valid
      validOutcomes <- c("heart attack",
                         "heart failure",
                         "pneumonia")
      
      if(!(outcome %in% validOutcomes)) {
            stop("invalid outcome")
      }
      
      
      ## For each state, find the hospital of the given rank ---------
      
      ## Get the column of the outcome 
      if(outcome == "pneumonia") 
            colNum <- which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia") 
      else if (outcome == "heart attack")
            colNum <- which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
      else if(outcome == "heart failure")
            colNum <- which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
      
      ## Extract hospital-State-outcome data
      hospitals <- as.character(data[,2])
      states <- as.character(data[,7])
      outcomes <- as.numeric(data[,colNum])
      
      ## Create a new frame with ordered clean data
      allData <- cbind(hospitals, states, outcomes)
      ordered <- allData[order(as.character(allData[,2]), as.numeric(allData[,3]), as.character(allData[,1])),]
      ordered <- na.omit(ordered)
      
      ## Separate data into lists by frame
      stateLists <- split(ordered, ordered[,2])
      
      #stateLists[1]
      ## Return a data frame with the hospital names and the ---------
      
      stateRanks <- matrix(ncol = 2) 
      #names(stateRanks) <- c("Hospital", "State", "Outcome")
      
      
      for(state in stateLists) {
            
            #stateData <- state[,2]
            data <- matrix(unlist(state), ncol = 3)
            

            if ( num == "best")
                  rank <- 1
            else if (num == "worst")
                  rank <- nrow(data)
            else if(nrow(data) < num) {
                  found <- data[1,1:2]
                  found[1] <- "<NA>"
                  stateRanks <- rbind(stateRanks, found)
                  next
            }
            else 
                  rank <- num
            
            found <- data[rank,1:2]         
                        
            stateRanks <- rbind(stateRanks, found)  

      }
      
      row.names(stateRanks) <- stateRanks[,2]
      colnames(stateRanks) <- c("hospital", "state")
      return(data.frame(stateRanks[2:nrow(stateRanks),]))
      
      ## (abbreviated) state name
      
}
