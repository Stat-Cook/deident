#' Function factory to apply white noise to a vector
#' 
#' @param sd the standard deviation of noise to apply.
#' 
#' @return a function
#' 
#' @examples 
#' 
#' f <- white_noise(1)
#' f(1:10)
#' 
#' @export
white_noise <- function(sd=0.1){
  function(values){
    rnorm(length(values), values, sd)
  }
}

#' Function factory to apply log-normal noise to a vector
#' 
#' @param sd the standard deviation of noise to apply.
#' 
#' @return a function
#' 
#' @examples 
#' 
#' f <- lognorm_noise(1)
#' f(1:10)
#' 
#' @export
#' @importFrom stats rlnorm
lognorm_noise <-  function(sd = 0.1){


  function(values){
    values*rlnorm(length(values), 0, sd)
  }
  
}

#' Function factory to apply white noise to a vector proportional to the spread 
#' of the data
#' 
#' @param sd.ratio the level of noise to apply relative to the vectors standard 
#' deviation.
#' 
#' @return a function
#' 
#' @examples 
#' 
#' f <- adaptive_noise(0.2)
#' f(1:10)
#' 
#' @export

#' 
#' @importFrom stats rnorm sd
adaptive_noise <-  function(sd.ratio = 1/10){

  function(values){
    .sd <- sd(values)
    .sd <- .sd*sd.ratio
    rnorm(length(values), values, .sd)
  }
  
}

# 
# initialize_perturb <- function(object, ...){
#   UseMethod("initialize_perturb")
# }
# 
# initialize_perturb.function <- function(object, ...){
#   return(object)
# }
# 
# initialize_perturb.numeric <- function(object, ...){
#   return(white_noise(object))
# }

initialize.pertuber <- function(noise, self){
  UseMethod("initialize.pertuber")
}

initialize.pertuber.function <- function(noise, self){
  self$method <- noise
  self
}

initialize.pertuber.numeric <- function(noise, self){
  self$method <- white_noise(noise)
  self
}

initialize.pertuber.character <- function(noise, self){
  self$noise.str <- noise
  self$method <- eval(parse(text=noise))

  self
}

#' R6 class for deidentification via random noise
#' 
#' @description  
#' A `Deident` class dealing with the addition of random noise to a 
#' numeric variable.
#' 
#' @param noise a single-argument function that applies randomness.
#' 
#' @examples 
#'   pert <- Perturber$new()
#'   pert$transform(1:10)
#' 
#' @export
Perturber <- R6Class(

  "Perturber", list(
    #' @field noise.str character representation of `noise`
    noise.str = NA,
    
    #' @field method random noise function
    method = NA,
    
    #' @description 
    #' Create new Perturber object
    initialize = function(noise=1){
      self$noise.str <- deparse(substitute(noise))
      self <- initialize.pertuber(noise, self)
    },
    
    #' @description 
    #' Apply noise to a vector of values
    #' @param keys Vector of values to be processed
    #' @param ... Values to be concatenated to keys
    transform = function(keys, ...){
      keys <- c(keys, ...)
      self$method(keys)
    },
    
    #' @description 
    #' `r serialize.desc()`
    serialize = function(){
      super$serialize(noise = self$noise.str)
    },
    
    #' @description 
    #' Character representation of the class
    str = function(){
      super.str <- super$str()
      glue("{super.str}({self$noise.str})")
    }
  ),
  inherit = BaseDeident
)


