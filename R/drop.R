Drop <- R6Class(
  #' @export
  "Drop",
  list(
    transform = function(keys, ...){

    },
    mutate = function(data, ...){
      dplyr::select(data, -c(...))

    }
  ),
  inherit = BaseDeident
)

