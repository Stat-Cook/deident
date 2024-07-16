Shuffler <- R6Class(
  #' Shuffler class for applying 'shuffling' transform
  #'
  #' 'Shuffling' refers to the a random sampling of a variable without
  #' replacement e.g. [A, B, C] becoming [B, A, C] but not [A, A, B].
  #' Shuffling will preserve top level metrics (e.g. mean, median, mode) but
  #' removes ordinal properties i.e. correlations and auto-correlations
  #'
  #' @param method [optional] A function representing the method of re-sampling
  #'   to be used.  By default uses exhaustive sampling without replacement.
  #'
  #' @export
  "Shuffler", list(
    limit = 0,
    initialize = function(method=sample, limit=0){
      self$set_method(method)
      self$set_limit(limit)
    },

    set_limit = function(limit){
      self$limit = limit
    },

    transform = function(keys, ...){
      keys <- c(keys, ...)

      len <- length(keys)
      if (len <= self$limit){
        return(rep(NA, len))
      }

      return(self$method(keys))
    },

    serialize = function(dots=NA){
      super$serialize(on_init = list(limit=self$limit), dots=dots)
    }

  ),
  inherit = BaseDeident
)



