#' Define a transformation pipeline
#' 
#' `deident()` creates a transformation pipeline of 'deidentifiers' for 
#' the repeated application of  anonymization transformations.  
#' 
#' @export
#' 
#' @param data  A data frame, existing pipeline, or a 'deidentifier' 
#' (as either initialized object, class generator, or character string)
#' 
#' @param deidentifier A deidentifier' (as either initialized object, 
#' class generator, or character string) to be appended to the current 
#' pipeline
#'   
#' @param ... Positional arguments are variables of 'data' to be transformed 
#' and key-word arguments are passed to 'deidentifier' at creation
#' 
#' @inherit new_deident return
#' @importFrom dplyr `%>%`
#' @examples 
#' 
#' # 
#' pipe <- deident(ShiftsWorked, Pseudonymizer, Employee)
#' 
#' print(pipe)
#' 
#' apply_deident(ShiftsWorked, pipe)
#'   
deident <- function(data, deidentifier, ...){
  UseMethod("deident", data)
}

#' @exportS3Method
deident.data.frame <- function(data, deidentifier=NULL, ...){
  
  dl <- DeidentList$new(data)
  
  if (is.null(deidentifier)){
    return(dl)
  }
  deident(dl, deidentifier, ...)
}

#' @exportS3Method
deident.DeidentList <- function(data, deidentifier, ...){
  
  if (is.list(deidentifier)){
    for (d in deidentifier){
      add_deident(data, d)
    }
    
    return(data)
  }
  
  data$add_method(deident=deidentifier, ...)
  
  
  data
}

#' @exportS3Method
deident.character <- function(data, deidentifier=NULL, ...){
  
  deident_without_data(data, {{deidentifier}}, ...)
}

#' @exportS3Method
deident.BaseDeident <- function(data, deidentifier=NULL, ...){
  
  deident_without_data(data, {{deidentifier}}, ...)
}

#' @exportS3Method
deident.R6ClassGenerator <- function(data, deidentifier=NULL, ...){
  
  deident_without_data(data, {{deidentifier}}, ...)
}

#' @exportS3Method
deident.list <- function(data, deidentifier=NULL, ...){
  
  deident_without_data(data, {{deidentifier}}, ...)
}


deident_without_data <- function(deidentifier, ...){
  UseMethod("deident_without_data", deidentifier)
}

#' @exportS3Method
deident_without_data.default <- function(deidentifier, ...){

  dl <- DeidentList$new()
  dl$add_method(deident=deidentifier, ...)
  dl
}

#' @exportS3Method
deident_without_data.list <- function(deidentifier, ...){
  
  dl <- DeidentList$new()
  for (d in deidentifier){
    add_deident(dl, d)
  }
  return(dl)
}


#' Apply a 'deident' pipeline to a new data frame
#' 
#' @param data The data set to be converted
#' @param transformer The pipeline to be used
#' @param ... To be passed on to other methods
#' 
#' @export
apply_to_data_frame <- function(data, transformer, ...){

  UseMethod ("apply_to_data_frame", transformer)
}

#' @exportS3Method
apply_to_data_frame.BaseDeident <- function(data, transformer, ...){

  data |> transformer$mutate(...)
}

# # @exportS3Method
# apply_to_data_frame.R6 <- function(data, transformer, ...){
# 
#  if ("transform" %in% names(transformer)){
#     mutated <- data |> transformer$mutate(...)
#   return(mutated)
# }
#   
#   return(data)
# }

#' @exportS3Method
apply_to_data_frame.DeidentTask <- function(data, transformer, ...){

  apply_to_data_frame(
    data, transformer$method,
    !!!transformer$variables
  )
}

#' @exportS3Method
apply_to_data_frame.R6ClassGenerator <- function(data, transformer, ...){

  deident_task <- create_deident(transformer, ...)
  deident_list_mutate(data, deident_task)
}

#' @exportS3Method
apply_to_data_frame.character <- function(data, transformer, ...){
  
  implemented_transforms <- implemented_transforms_base.f()
  
  if (transformer %in% names(implemented_transforms)){
    
    deident_task <- create_deident(transformer, ...)
    return(deident_list_mutate(data, deident_task))
  }
  return(data)
}

# @exportS3Method
# apply_to_data_frame.list <- function(data, transformer, ...){
#   
#   implemented_transforms <- implemented_transforms_base.f()
#   
#   if (transformer %in% names(implemented_transforms)){
#     init.list <- init.list.f(on_init = transformer$OnInit, dot.args = transformer$Dots)
#     deident_task <- create_deident(transformer$Type, ...)
#     return(deident_list_mutate(data, deident_task))
#   }
#   return(data)
# }
