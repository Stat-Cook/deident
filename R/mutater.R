Mutater <- R6Class(
  "Mutater",
  list(
    to_do = NA,
  
    initialize = function(...){
      enq <- enquos(...)
      self$to_do <- map(enq, rlang::quo_squash)
    },
    
    mutate = function(data, ...){
      job <- append(
        list(data),
        self$to_do
      )
      
      do.call(dplyr::mutate, job)
      
    },
    
    serialize = function(){
      # TODO: implement some fix for this
      stop("'serialize' not currently implemented for the 'Mutater class'")
    }
    
    # str = function(){
    #   super.str <- super$str()
    #   fn.str.trunc <- stringr::str_trunc(
    #     self$fn.str, 
    #     width = 32)
    #   glue("{super.str}(fn = {fn.str.trunc})")
    # }
    
  ),
  inherit = BaseDeident
)


