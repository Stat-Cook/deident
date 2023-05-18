deident <- function(data, deidentifier, ..., init.list=list()){
  #' @export
  UseMethod("deident", data)
}

deident.data.frame <- function(data, deidentifier, ..., init.list=list()){
  #' @exportS3Method
  #'

  UseMethod("apply_to_data_frame", deidentifier)
}

deident.DeidentList <- function(data, deidentifier, ..., init.list=list()){
  #' @exportS3Method

  data$add_method(deident=deidentifier, ..., init.list=init.list)
  data
}

# frm <- data.frame(A = letters, B =LETTERS)
# dl <- DeidentList$new(frm)
# deident(dl, Encrypter, B, init.list=list(hash_key="ABC"))
#
# dl$add_method(Encrypter, B)

apply_to_data_frame <- function(data, transformer, ..., init.list=list()){
  #' @export
  UseMethod ("apply_to_data_frame", transformer)
}

apply_to_data_frame.BaseDeident <- function(data, transformer, ..., init.list=list()){
  #' @exportS3Method
  data |> transformer$mutate(...)
}

apply_to_data_frame.R6 <- function(data, transformer, ..., init.list=list()){
  #' @exportS3Method
  if ("transform" %in% names(transformer)){
    mutated <- data |> transformer$mutate(...)
    return(mutated)
  }

  return(data)
}

apply_to_data_frame.DeidentTask <- function(data, transformer, ..., init.list=list()){
  #' @exportS3Method
  #'
  apply_to_data_frame(
    data, transformer$method,
    !!!enc2$variables, init.list=init.list
  )
}

apply_to_data_frame.R6ClassGenerator <- function(data, transformer, ..., init.list=list()){
  #' @exportS3Method
  deident_task <- create_deident(transformer, ..., init.list=init.list)
  deident_list_mutate(data, deident_task)
}

apply_to_data_frame.character <- function(data, transformer, ..., init.list=list()){
  #' @exportS3Method

  implemented_transforms <- implemented_transforms_base.f()

  if (transformer %in% names(implemented_transforms)){

    deident_task <- create_deident(transformer, ..., init.list=init.list)
    return(deident_list_mutate(data, deident_task))
  }
  return(data)
}

apply_to_data_frame.list <- function(data, transformer, ..., init.list=list()){
  #' @exportS3Method

  implemented_transforms <- implemented_transforms_base.f()

  if (transformer %in% names(implemented_transforms)){
    init.list <- init.list.f(on_init = transformer$OnInit, dot.args = transformer$Dots)
    deident_task <- create_deident(transformer$Type, ..., init.list=init.list)
    return(deident_list_mutate(data, deident_task))
  }
  return(data)
}
