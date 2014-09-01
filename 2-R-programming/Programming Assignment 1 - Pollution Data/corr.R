
## Write a function that takes a directory of data files 
## and a threshold for complete cases and calculates the 
## correlation between sulfate and nitrate for monitor 
## locations where the number of completely observed cases 
## (on all variables) is greater than the threshold. 
## The function should return a vector of correlations 
## for the monitors that meet the threshold requirement. 
## If no monitors meet the threshold requirement, then the 
## function should return a numeric vector of length 0. 

corr <- function(directory, threshold = 0) {
      
      files <- c(dir(directory))
      files
      
      ##resultFrame <- data.frame(id = c(), nobs = c(), stringsAsFactors = default.stringsAsFactors())
      resultFrame <- c()
      
      
      ##Loop through vector of files
      for(i in files)
      {
            ##Extract file data
            filePath <- paste(directory, "/", toString(i), sep = '')
            newFile <- read.csv(filePath)
            
            goodCases <- newFile[complete.cases(newFile),]
            
            
            if(length(goodCases) > 0)
            {
                  nobs <- nrow(goodCases)
            
                  if(length(nobs) > 0)
                  {
                        if(nobs > threshold)
                        {
                              correlation <- cor(goodCases[,2],goodCases[,3]);
                              resultFrame <- c(resultFrame, correlation)
                        }
                  }

            }
      }
      

      resultFrame
      
      ## 'directory' is a character vector of length 1 indicating
      ## the location of the CSV files
      
      ## 'threshold' is a numeric vector of length 1 indicating the
      ## number of completely observed observations (on all
      ## variables) required to compute the correlation between
      ## nitrate and sulfate; the default is 0
      
      ## Return a numeric vector of correlations
}




