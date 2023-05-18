white_noise <-  function(sd = 1){
  #' @importFrom stats rnorm
  function(values){
    rnorm(length(values), values, sd)
  }
}

Perturber <- R6Class(
  #' @export
  "Perturber", list(
    sd = NA,

    initialize = function(sd=1){
      self$sd = sd
      self$method = white_noise(sd)
    },

    transform = function(keys, ...){
      keys <- c(keys, ...)
      self$method(keys)
    },

    serialize = function(){
      super$serialize(on_init = list(sd = self$sd))
    },

    str = function(...){
      super.str <- super$str()
      glue("{super.str}(sd = {self$sd})")
    }
  ),
  inherit = BaseDeident
)

perturb <- function(data, perturber, ...){
  UseMethod("perturb", perturber)
}

perturb.Perturber <- function(data, perturber, ...){
  data |> perturber$mutate(...)
}

perturb.function <- function(data, func, ...){
  pert <- Perturber$new(func)
  data |> pert$mutate(...)
}
