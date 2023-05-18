numeric_blur.f <- function(cuts){
  function(values){
    cuts <- c(-Inf, cuts, Inf)
    cut(values, cuts)
  }
}
cut(1:10, c(-Inf, 4, Inf))

numeric_blur.f(c(2, 4))


NumericBlurer <- R6Class(
  #' @export
  "NumericBlurer", list(

    cuts = NA,

    initialize = function(cuts){
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

# frm <- data.frame(
#   A = sample(letters[1:2], 100, T),
#   B = sample(letters[1:2], 100, T),
#   C = rnorm(100)
# )
#
# nb <- NumericBlurer$new(c(0, 4))
# nb$method(rnorm(100))
# nb$transform(frm$C)
#
# nb$mutate(frm, C)


#
# nb$method
# # (frm, C)
