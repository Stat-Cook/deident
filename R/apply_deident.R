apply_deident <- function(object, deident, ...){
  UseMethod("apply_deident")
}

apply_deident.data.frame <- function(object, deident, ...){
  deident$mutate(object)
}

apply_deident.character <- function(object, deident, ...){

  df <- read_data(object, ...)
  apply_deident(df, deident, ...)
}


