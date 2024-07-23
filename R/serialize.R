#' @description 
#' Convert `self` to a list 
#' @noRd
serialize <- function(x, ...){
  UseMethod("serialize", x)
}


