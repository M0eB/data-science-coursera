
## Write a function that reads a directory full of files and reports 
## the number of completely observed cases in each data file. 
## The function should return a data frame where the first column is 
## the name of the file and the second column is the number of complete cases. 

complete <- function(directory, id = 1:332) {
      
      resultFrame <- data.frame(id = c(), nobs = c(), stringsAsFactors = default.stringsAsFactors())
      
      ##Loop through vector of files
      for(i in id)
      {
            
            if(i < 10)
                  prefix <- "/00"
            else if (i >= 10 && i < 100)
                  prefix <- "/0"
            else
                  prefix <- "/"
            
            ##Extract file data
            filePath <- paste(directory, prefix, toString(i), ".csv", sep = '')
            newFile <- read.csv(filePath)
            
            completeCases <- complete.cases(newFile)
            completeData <-  completeCases[completeCases > FALSE]
            newRow <- data.frame(id = toString(i), nobs = length(completeData))
            resultFrame <- rbind(resultFrame, newRow)
      }
      
      resultFrame
      
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
}
