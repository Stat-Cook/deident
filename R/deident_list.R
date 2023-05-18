#' create_deident <- function(method, ...){
#'   #' @export
#'
#'   UseMethod("create_deident",method)
#' }
#'
#' create_deident.BaseDeidentifier <- function(method, ...){
#'   #' @export
#'   #' @importFrom rlang enquos
#'
#'   l <- list(
#'     Variables = enquos(...),
#'     Deidentifier = method
#'   )
#'   class(l) <- "DeidentTask"
#'   l
#' }
#'
#' create_deident.character <- function(method, ...){
#'   #' @export
#'
#'   implemented_transforms <- implemented_transforms_base.f()
#'   .tra <- implemented_transforms[[method]]
#'   .tra <- .tra$new()
#'   create_deident(.tra, ...)
#' }
#' #'
#' #' apply_task <- function(data, task){
#' #'   #' @export
#' #'
#' #'   deidentifier <- task$Deidentifier
#' #'   vars <- task$Variables
#' #'   deidentifier$mutate(data, !!!vars)
#' #' }
#' #'
#' #'
#' #' DeidentList <- R6Class("DeidentList", list(
#' #'   #' @export
#' #'
#' #'   tasks = NA,
#' #'
#' #'   initialize = function(tasks=list()){
#' #'     self$tasks = tasks
#' #'   },
#' #'
#' #'   append_to_tasks = function(task){
#' #'     self$tasks <- append(self$tasks, list(task))
#' #'   },
#' #'
#' #'   add_task = function(method, ...){
#' #'     task <- create_deident(method, ...)
#' #'     self$append_to_tasks(task)
#' #'   },
#' #'
#' #'   apply_tasks = function(data){
#' #'     to_reduce <- prepend(self$tasks, list(data))
#' #'     reduce(to_reduce, apply_task)
#' #'   }
#' #' ))
#' #'
#' #'
#' #' add_task <- function(deident_list, ...){
#' #'   #' @export
#' #'
#' #'   deident_list$add_task(...)
#' #'   deident_list
#' #' }
#' #'
#' #' init_dlist <- function(){
#' #'   #' @export
#' #'
#' #'   DeidentList$new()
#' #' }
#' #'
#' #' apply_deident <- function(data, deident){
#' #'   #' @export
#' #'
#' #'   deident$apply_tasks(data)
#' #' }
#' #'
