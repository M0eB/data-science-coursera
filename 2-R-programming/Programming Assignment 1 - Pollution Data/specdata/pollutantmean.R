



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


pollutantmean <- function(directory, pollutant, id = 1:332) {
        
        ##Loop through vector of files
        for(i in id)
        {
                #Extract file data
                filePath <- paste(directory, toString(i), ".csv")
                newFile <- read.csv(filePath)
        
                #Extract Pollutant values
                if(pollutant == "sulfate")
                {
                       newData <- newFile[,2]   
                
                } else if (pollutant == "nitrate") {
                        
                        newData <- newFile[,3]        
                        
                }
        
                #Concatenate new data
        
                
        
        ##Remove NA values
        
        
        ##Get mean of data
        
        
        ##return values
                
        }
}


pollutantmean("specdata", "sulfate", 1:10)


