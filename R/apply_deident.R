#' Apply a 'deident' pipeline
#' 
#' Applies a pipeline as defined by `deident` to a data frame. tibble, or file.
#' 
#' @param object The data to be deidentified
#' @param deident A deidentification pipeline to be used.
#' @param ... Terms to be passed to other methods
#' 
#' @export
apply_deident <- function(object, deident, ...){
  UseMethod("apply_deident")
}

apply_deident.data.frame <- function(object, deident, ...){
  #' @exportS3Method
  
  deident$mutate(object)
}

apply_deident.character <- function(object, deident, ...){
  #' @exportS3Method
  df <- read_data(object, ...)
  apply_deident(df, deident, ...)
}


