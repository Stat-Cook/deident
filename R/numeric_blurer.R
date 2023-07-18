numeric_blur.f <- function(cuts){
  function(values){
    cuts <- c(-Inf, cuts, Inf)
    cut(values, cuts)
  }
}


NumericBlurer <- R6Class(
  #' @export
  "NumericBlurer", list(

    cuts = NA,

    initialize = function(cuts=0){
      self$cuts = cuts
      self$method = function(values) {
        cuts <- c(-Inf, self$cuts, Inf)
        cut(values, cuts)
      }
    },

    transform = function(keys, ...){
      keys <- c(keys, ...)
      self$method(keys)
    },

    serialize = function(){
      super$serialize(on_init = list(cuts = self$cuts))
    }
  ),
  inherit = BaseDeident
)
