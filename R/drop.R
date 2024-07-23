#' R6 class for the removal of variables from a pipeline
#' 
#' @description  
#' A `Deident` class dealing with the exclusion of variables.
#' 
#' @export
Drop <- R6Class(

  "Drop",
  list(
    transform = function(keys, ...){

    },
    mutate = function(data, ...){
      remove_if_exists(data, ...)
    }
  ),
  inherit = BaseDeident
)


remove_if_exists <- function(frm, ...){

  to_drop <- overlap(frm, ...)
  select(frm, -all_of(to_drop))
}
