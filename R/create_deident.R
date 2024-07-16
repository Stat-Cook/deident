create_deident <- function(method, ..., init.list=list()){
  #' @export

  UseMethod("create_deident",method)
}

create_deident.BaseDeident <- function(method, ..., init.list=list()){

  #' @exportS3Method
  #' @importFrom rlang enquos

  l <- list(
    variables = enquos(...),
    method = method
  )
  class(l) <- "DeidentTask"
  l
}

create_deident.R6ClassGenerator <- function(method, ..., init.list=list()){
  #' @exportS3Method
  #' @export

  .tra <- do.call(method$new, init.list)
  create_deident(.tra, ...)
}

create_deident.list <- function(object, ...){
  #' @exportS3Method
  init.list <- init.list.f(on_init = object$OnInit, dot.args = object$Dots)
  create_deident(object$Type, ..., init.list = init.list)
}

create_deident.character <- function(method, ..., init.list = list()){
  #' @exportS3Method
  #' @export

  implemented_transforms <- implemented_transforms_base.f()
  .tra <- implemented_transforms[[method]]
  
  if (is.null(.tra)){
    stop(glue::glue("Transform method {method} not implemented"))
  }
  
  create_deident(.tra, ..., init.list = init.list)
}


str.DeidentTask <- function(object, ...){
  #' @exportS3Method
  labels <- quosure_as_labels(object$variables)
  glue("'{object$method$str()}' on variable(s) \\
       {paste(labels, collapse=', ')}")
}

