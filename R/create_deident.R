#' Create a deident pipeline 
#' 
#' @param method A deidentifier to initialize.
#' @param ... list of variables to be deidentified. NB: key word arguments will 
#' be passed to method at initialization.
#' 
#' @export
create_deident <- function(method, ...){


  UseMethod("create_deident",method)
}

create_deident.BaseDeident <- function(method, ...){

  #' @exportS3Method
  #' @importFrom rlang enquos
  #'

  unexpected_kwargs(...)
  dots <- arg_kwarg(...)

  l <- list(
    variables = dots$args,
    method = method
  )
  class(l) <- "DeidentTask"
  l
}

create_deident.R6ClassGenerator <- function(method, ...){
  #' @exportS3Method
  #' @export

  dots <- arg_kwarg(...)

  init.list <- purrr::map(dots$kwargs, rlang::quo_get_expr)
    
  .tra <- do.call(method$new, init.list)
  
  create_deident(.tra, !!!dots$args)

}

create_deident.GrouperR6ClassGenerator <- function(method, ...){
  #' @exportS3Method
  #' @export
  #' 

  l <- list(
    variables = c(),
    method = method$new(...)
  )

  class(l) <- "DeidentTask"
  l
}

create_deident.list <- function(method, ...){
  #' @exportS3Method
  
  create_deident(method$Type, !!!method$variables, !!!method$args)
}

create_deident.character <- function(method, ...){
  #' @exportS3Method
  #' @export

  implemented_transforms <- implemented_transforms_base.f()
  .tra <- implemented_transforms[[method]]
  
  if (is.null(.tra)){
    abort(glue::glue("Transform method {method} not implemented"))
  }
  
  create_deident(.tra, ...)
}


str.DeidentTask <- function(object, ...){
  #' @exportS3Method
  labels <- quosure_as_labels(object$variables)
  glue("'{object$method$str()}' on variable(s) \\
       {paste(labels, collapse=', ')}")
}

