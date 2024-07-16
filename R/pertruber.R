white_noise <- function(sd=0.1){
  function(values){
    rnorm(length(values), values, sd)
  }
}

lognorm_noise <-  function(sd = 0.1){
  #' @importFrom stats rnorm

  function(values){
    values*rlnorm(length(values), 0, sd)
  }
  
}

adaptive_noise <-  function(sd.ratio = 1/10){
  #' @importFrom stats rnorm

  function(values){
    .sd <- sd(values)
    .sd <- .sd*sd.ratio
    rnorm(length(values), values, .sd)
  }
  
}


initialize_perturb <- function(object, ...){
  UseMethod("initialize_perturb")
}

initialize_perturb.function <- function(object, ...){
  return(object)
}

initialize_perturb.numeric <- function(object, ...){
  return(white_noise(object))
}


Perturber <- R6Class(
  #' @export
  "Perturber", list(
    noise.str = NA,
    method = NA,
    
    
    initialize = function(noise=1){
      self$noise.str <- deparse(substitute(noise))
      self$method = initialize_perturb(noise)

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
      glue("{super.str}({self$noise.str})")
    }
  ),
  inherit = BaseDeident
)

