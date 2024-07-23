#' Shuffler class for applying 'shuffling' transform
#'
#' 'Shuffling' refers to the a random sampling of a variable without
#' replacement e.g. \[A, B, C\] becoming \[B, A, C\] but not \[A, A, B\].
#' Shuffling will preserve top level metrics (e.g. mean, median, mode) but
#' removes ordinal properties i.e. correlations and auto-correlations
#'
#' @param method \[optional\] A function representing the method of re-sampling
#'   to be used.  By default uses exhaustive sampling without replacement.
#' @param keys Value(s) to be transformed.
#' @param ... Value(s) to concatenate to `keys` and transform
#'  @inheritParams Pseudonymizer 
#' @param limit integer - the minimum number of observations a variable needs to 
#' have for shuffling to be performed.  If the variable has length less than `limit`
#' values are repalced with `NA`s. 
#'   
#' @export
Shuffler <- R6Class(

  "Shuffler", list(
    #' @field limit minimum vector length to be shuffled.  If vector to be 
    #' transformed has length < limit, the data is replaced with NAs
    limit = 0,
    
    #' @description 
    #' Create new Shuffler object
    initialize = function(limit=0){
      self$set_method(sample)
      self$set_limit(limit)
    },
    
    #' @description 
    #' Update minimum vector size for shuffling
    set_limit = function(limit){
      self$limit = limit
    },

    #' @description  
    #' `r transform.desc()`
    #' 
    transform = function(keys, ...){
      keys <- c(keys, ...)

      len <- length(keys)
      if (len <= self$limit){
        return(rep(NA, len))
      }

      return(self$method(keys))
    },

    #' @description 
    #' `r serialize.desc()`
    serialize = function(){
      super$serialize(limit=self$limit)
    }

  ),
  inherit = BaseDeident
)



