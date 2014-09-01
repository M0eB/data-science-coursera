## Course : R Programming (Coursera)

## DESCRIPTION : 
##    This file contains functions that handle the creations of
##    a special matrix object capable of caching the matrix
##    inverse value. The available functions include :
##          makeCacheMatrix()
##          cacheSolve()

## makeCacheMatrix : 
##      Create a special matrix with an inverse property that
##      can be used to cache the inverse of the input matrix.
##      The created object will have built in methods to set      
##      and get the values of the matrix and its inverse/.
##      Functions Include :
##          get : returns the matrix value
##          set : sets the matrix value to the input matrix
##          setInverse : sets the inverse value to the input
##          getInverse : gets the cached matrix inverse 

## cacheSolve :
##    This function will return the inverse of the input
##    matrix if it has been previously calculated OR 
##    calculate the inverse, cache it, and return the result


## Create a special matrix object with an inverse property
makeCacheMatrix <- function(x = matrix()) {
      invMatrix <- NULL
      
      set <- function(y) {
            x <<- y              #update matrix value
            invMatrix <<- NULL   #reset inverse for new matrix
      }
      
      get <- function() x      
      setInverse <- function(inverse) invMatrix <<- inverse
      getInverse <- function() invMatrix
      
      #Return a list of functions to use on the object
      list(set = set, 
           get = get, 
           setInverse = setInverse, 
           getInverse = getInverse)
}


## Return the inverse of the input matrix
cacheSolve <- function(x, ...) {
      ## Return a matrix that is the inverse of 'x'
      
      invMatrix <- x$getInverse()  #Get the cached inverse
      
      #Return inverse if found to be previously cached
      if(!is.null(invMatrix))
      {
            message("Getting chached inverse matrix")
            return (invMatrix)
      }
      
      matrix <- x$get()          #Get matrix to calcuate inverse
      invMatrix <- solve(matrix) #Calculate inverse
      x$setInverse(invMatrix)    #Cache result
      invMatrix                  #Print result
}
