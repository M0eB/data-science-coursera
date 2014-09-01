

best <- function(state, outcome) {
      
      ## Read outcome data
      data <- read.csv("outcome-of-care-measures.csv", na.strings=c("Not Available"))
      
      ## Check that the state is valid
      if(!(state %in% data$State)) {
            stop("invalid state")
      }
      
      ## Check that state and outcome are valid
      validOutcomes <- c("heart attack",
                         "heart failure",
                         "pneumonia")
      
      if(!(outcome %in% validOutcomes)) {
            stop("invalid outcome")
      }
            
      # Get the hospitals in the input state
      inState <- data$State == state
      stateHospitals <- data[inState,]

      if(outcome == "pneumonia") 
            colNum <- which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia") 
      else if (outcome == "heart attack")
            colNum <- which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
      else if(outcome == "heart failure")
            colNum <- which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")

      #sort by outcome then by hospital name
      outcomes <- as.numeric(stateHospitals[,colNum])
      hospitals <- as.character(stateHospitals[,2])
      outcomeData <- cbind(hospitals, outcomes)
      ordered <- outcomeData[order(outcomeData[,2], outcomeData[,1]),]   
      
      #stateHospitals <- stateHospitals[order(data[,colNum], data[,2]),]
      ordered <- na.omit(ordered)
      rate <- ordered[,2]
      
      ## Find lowest mortality rate
      lowestRate <- which.min(rate)
      return(as.character(ordered[lowestRate,1]))
      
}
