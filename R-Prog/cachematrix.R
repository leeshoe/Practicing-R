## Tim Shores, Coursera R Programming class, Assignment 2
## First function creates matrix from argument input and creates a list 'object' with
## methods to get matrix, set a new matrix, and get the inverse of the matrix.
## Second function provides a way to spare excess computation by caching matrix inverse.

# makeCacheMatrix creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  
  mymatrix_inverse <<- NULL
  
  set <- function(y) {
    x <<- y
    mymatrix_inverse <<- NULL
  }
  get <- function() x
  getinverse <- function() solve(x)
  
  return(list(set = set, get = get, getinverse = getinverse))
  
}


# cacheSolve does the following: computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
### tests for inverted matrix variable cached in the environment. 
### IF it is not NULL (it has data), then report that we're returning the cache.
### ELSE use solve() to invert the x matrix, and cache it.
### Either way, same variable is returned, the cached mymatrix_inverse.

cacheSolve <- function(x, ...) {

  if(!is.null(mymatrix_inverse)) {
    
      message("getting cached data")
    
    } else {
    
      mymatrix_inverse <<- solve(x$get())
          
    }
  
  return(mymatrix_inverse)
 

}
