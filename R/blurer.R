# blur.f <- function(key, vec){
#   if (key %in% names(vec)){
#     return(vec[[key]])
#   }
#   return(key)
# }
# 
# blur <- Vectorize(blur.f, "key")


blur <- function(vec, .blur){
  corrected <- names(.blur)
  not_in_blur <- setdiff(unique(vec), corrected)
  
  names(not_in_blur) <- not_in_blur
  compelete.blur <- c(.blur, not_in_blur)
  
  simplify(compelete.blur[vec])
}


#' Deidentifier class for applying 'blur' transform
#'
#' 'Bluring' refers to aggregation of data e.g. converting city to country,
#' or post code to IMD.  The level of blurring is defined by the list given
#' at initialization which maps key to value e.g.
#' list(London = "England", Paris = "France").
#'
#' @export
Blurer <- R6Class(
  "Blurer", list(
    #' @field blur List of aggregations to be applied.
    blur = NA,

    #' Create new Blurer object
    #' @param blur   Look-up list to define aggregation.
    #' @return `Blurer`
    initialize = function(blur = c()){
      self$blur = blur
      self$method = function(keys) blur(keys, self$blur)
    },

    #' Apply blur to a vector of values
    #' @param keys Vector of values to be processed
    #' @param ... Values to be concatenated to keys
    transform = function(keys, ...){
      keys <- c(keys, ...)
      self$method(keys)
    },

    serialize = function(){
      super$serialize(on_init = list(blur = self$blur))
    }
  ),
  inherit = BaseDeident
)




