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


