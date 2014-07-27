## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
# creates a list to encapsulate a matrix with various helper functions for that matrix, particularly a caching mechanism
# logic for the caching is not included here, this function only creates the data structure that will be used by separate
# caching logic. 
# helper functions include: 
# getInverse: returns the matrix inverse (computation is cached automatically, no need to set the value manually...)
# get and set: getting and setting the matrix object (setting clears the cached inverse)
# makeCacheMatrix ssumes the matrix is always invertible
makeCacheMatrix <- function(subjectMatrix = matrix()) {
  inverse <- NULL
  set <- function(newMatrix) {
    subjectMatrix <<- newMatrix
    inverse <<- NULL
  }
  
  get <- function() {
    subjectMatrix
  }
  
  getInverse <- function() {
    inverse
  }
  
  setInverse <- function(newInverse) {
    inverse <<- newInverse
  }
  
  # assign a reference to the function to the label of the same name
  list(set = set, get = get, getInverse = getInverse, setInverse = setInverse)

}


## Write a short comment describing this function
# a caching wrapper for the solve() command when being used to calculate the matrix inverse. 
# to be used in conjunction with makeCacheMatrix, expects a data structure defined by makeCacheMatrix()
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
    
  if (is.null(x$getInverse())) {
    # compute and cache the matrix inverse
    message("cachematrix: cache empty, calculating inverse with solve()")
    x$setInverse(solve(x$get(), ...))    
  } else {
    #report that we're using a cached value
    message("cachematrix: using cached value")
  }
  
  # return the cached inverse
  x$getInverse()
  
}
