
UserDefinedDeident <- R6Class(
  "UserDefinedDeident", list(
    initialize = function(method){
      self$method = method
    }
  ),
  inherit = BaseDeident
)

deident_from_func <- function(method){
  UserDefinedDeident$new(method)
}
