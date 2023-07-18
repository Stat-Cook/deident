deident <- function(data, deidentifier, ..., init.list=list()){
  #' @export
  UseMethod("deident", data)
}

deident.data.frame <- function(data, deidentifier=NULL, ..., init.list=list()){
  #' @exportS3Method
  #'

  dl <- DeidentList$new(data)

  if (is.null(deidentifier)){
    return(dl)
  }
  deident(dl, deidentifier, ..., init.list=init.list)
}

deident.DeidentList <- function(data, deidentifier, ..., init.list=list()){
  #' @exportS3Method

  if (is.list(deidentifier)){
    for (d in deidentifier){
      # init.list <- init.list.f(d$OnInit, d$Dots)
      # variables <- lapply(d$Variables, as.symbol)
      #
      # data$add_method(
      #   deident=d$Type, !!!variables,
      #   init.list=init.list)

      add_deident(data, d)
    }

    return(data)
  }

  data$add_method(deident=deidentifier, ..., init.list=init.list)


  data
}

deident.character <- function(data, deidentifier=NULL, ..., init.list=list()){
  #' @exportS3Method
  #'
  deident_without_data(data, {{deidentifier}}, ..., init.list=init.list)
}

deident.BaseDeident <- function(data, deidentifier=NULL, ..., init.list=list()){
  #' @exportS3Method
  #'

  deident_without_data(data, {{deidentifier}}, ..., init.list=init.list)
}

deident.R6ClassGenerator <- function(data, deidentifier=NULL, ..., init.list=list()){
  #' @exportS3Method
  #'
  deident_without_data(data, {{deidentifier}}, ..., init.list=init.list)
}

deident.list <- function(data, deidentifier=NULL, ..., init.list=list()){
  #' @exportS3Method
  #'
  deident_without_data(data, {{deidentifier}}, ..., init.list=init.list)
}


deident_without_data <- function(deidentifier, ..., init.list=list()){
  UseMethod("deident_without_data", deidentifier)
}

deident_without_data.default <- function(deidentifier, ..., init.list=list()){
  #' @exportS3Method
  dl <- DeidentList$new()
  dl$add_method(deident=deidentifier, ..., init.list=init.list)
  dl
}

deident_without_data.list <- function(deidentifier, ..., init.list=list()){
  #' @exportS3Method
  dl <- DeidentList$new()
  for (d in deidentifier){
    add_deident(dl, d)
  }
  return(dl)
}


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
    !!!transformer$variables, init.list=init.list
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
