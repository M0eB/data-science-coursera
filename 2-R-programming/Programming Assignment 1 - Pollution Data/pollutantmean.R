
## Write a function named 'pollutantmean' that calculates 
## the mean of a pollutant (sulfate or nitrate) across a 
## specified list of monitors. The function 'pollutantmean' 
## takes three arguments: 'directory', 'pollutant', and 'id'. 
## Given a vector monitor ID numbers, 'pollutantmean' reads 
## that monitors' particulate matter data from the directory 
## specified in the 'directory' argument and returns the mean 
## of the pollutant across all of the monitors, ignoring any 
## missing values coded as NA.


pollutantmean <- function(directory, pollutant, id = 1:332) {
    
        allData <- c()
      
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
                
            #Extract Pollutant values
            if(pollutant == "sulfate")
            {
                  newData <- newFile[,2]   
            } else if (pollutant == "nitrate") {
                  newData <- newFile[,3]                    
            }

            #Concatenate new data
            allData <- c(allData,newData)
        }
        
        #Remove NA and get mean
        mean <- mean(allData, na.rm = TRUE)
        mean
}


