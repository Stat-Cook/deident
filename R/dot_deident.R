BaseDotDeident <- R6Class(
  "BaseDotDeident",
  list(
    serialize = function(quosure){
      .quosure <- quosure 
      names(.quosure) <- seq_along(.quosure)
      
      do.call(super$serialize, .quosure)
    }
  ),
  inherit = BaseDeident
  
)
