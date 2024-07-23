Tidyer <- R6Class(
  "Tidyer",
  list(
    fn = NA,
    fn.str = NA,
    
    call = NA,
    
    initialize = function(fn){
      self$fn.str = deparse(substitute(fn))
      self$fn = fn
    },
    
    mutate = function(data, ...){
      as_mapper(self$fn)(data)
    },
    
    serialize = function(){
      # TODO: implement some fix for this
      stop("'serialize' not currently implemented for the 'Tidyer' class")
    },
    
    str = function(){
      super.str <- super$str()
      fn.str.trunc <- stringr::str_trunc(
        self$fn.str, 
        width = 32)
      glue("{super.str}(fn = {fn.str.trunc})")
    }
    
  ),
  inherit = BaseDeident
)

