Drop <- R6Class(
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

