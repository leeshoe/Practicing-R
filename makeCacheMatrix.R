makeCacheMatrix <- function(x = matrix()) {
  # This function creates a special "matrix" object that can cache its inverse.
  
  #mymatrix <- matrix(sample.int(999, size=9*9, replace=T), nrow=9, ncol=9)
  
  mymatrix_inverse <<- NULL
  
  set <- function(y) {
    x <<- y
    mymatrix_inverse <<- NULL
  }
  get <- function() x
  getinverse <- function() solve(x)
  
  return(list(set = set, get = get, getinverse = getinverse))
  
}

cacheSolve <- function(x, ...) {
  # This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
  # If the inverse has already been calculated (and the matrix has not changed), then the cachesolve 
  # should retrieve the inverse from the cache.
  
  # Computing the inverse of a square matrix can be done with the solve function.
  # For example, if X is a square invertible matrix, then solve(X) returns its inverse.
  
  if(!is.null(mymatrix_inverse)) {
    
      message("getting cached data")
    
    } else {
    
      mymatrix_inverse <<- solve(x$get())
          
    }
  
  return(mymatrix_inverse)
  
}