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
  init.list <- init.list.f(on_init = object$OnInit, dot.args = object$Dots)
  create_deident(object$Type, ..., init.list = init.list)
}

create_deident.character <- function(method, ..., init.list = list()){
  #' @exportS3Method
  #' @export

  implemented_transforms <- implemented_transforms_base.f()
  .tra <- implemented_transforms[[method]]
  create_deident(.tra, ..., init.list = init.list)
}

str.DeidentTask <- function(object, ...){
  #' @exportS3Method
  labels <- quosure_as_labels(object$variables)
  glue("'{object$method$str()}' on variable(s) \\
       {paste(labels, collapse=', ')}")
}

#'
#' apply_task <- function(data, task){
#'   #' @export
#'
#'   deidentifier <- task$Deidentifier
#'   vars <- task$Variables
#'   deidentifier$mutate(data, !!!vars)
#' }
#'
#'
#' DeidentList <- R6Class("DeidentList", list(
#'   #' @export
#'
#'   tasks = NA,
#'
#'   initialize = function(tasks=list()){
#'     self$tasks = tasks
#'   },
#'
#'   append_to_tasks = function(task){
#'     self$tasks <- append(self$tasks, list(task))
#'   },
#'
#'   add_task = function(method, ...){
#'     task <- create_deident(method, ...)
#'     self$append_to_tasks(task)
#'   },
#'
#'   apply_tasks = function(data){
#'     to_reduce <- prepend(self$tasks, list(data))
#'     reduce(to_reduce, apply_task)
#'   }
#' ))
#'
#'
#' add_task <- function(deident_list, ...){
#'   #' @export
#'
#'   deident_list$add_task(...)
#'   deident_list
#' }
#'
#' init_dlist <- function(){
#'   #' @export
#'
#'   DeidentList$new()
#' }
#'
#' apply_deident <- function(data, deident){
#'   #' @export
#'
#'   deident$apply_tasks(data)
#' }
#'
