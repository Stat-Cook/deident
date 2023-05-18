is.na.f <- function(x){
  if (inherits(x, "function"))
    return(FALSE)
  return(is.na(x))
}

#' Base class for all De-identifier classes
#' @importFrom R6 R6Class
#' @importFrom dplyr mutate group_by group_modify
BaseDeident <- R6Class(
  "BaseDeident",
  list(
    #' @field method Function to call for data transform.
    method = NA,

    #' Create new Deidentifier object
    #' @param method (optional)
    #' @return `Encrypter`
    initialize = function(method = NA){
      if (is.na.f(method)){
        self$method = function(i) i
      }
      else {
        self$method = method
      }
    },

    #' Setter for 'method' field
    #' @param method New function to be used as the method.
    set_method = function(method){
      self$method = method
    },

    #' Save 'Deidentifier' to serialized object.
    #' @param location File path to save to.
    persist = function(location){
      # TODO: Capture dependencies
      saveRDS(self, location)
    },

    #' Apply 'method' to a vector of values
    #' @param keys Vector of values to be processed
    #' @param ... Values to be concatenated to keys
    transform = function(keys, ...){
      keys <- c(keys, ...)
      self$method(keys)
    },

    #' Apply 'method' to variables in a data frame
    #' @param data A data frame to be manipulated
    #' @param ... Symbol representations of variables in 'data'
    mutate = function(data, ..., force=T){
      if (force){
        across.dots <- overlap(data, ...)
        return(mutate(data, across(across.dots, self$transform)))

      }
      mutate(data, across(c(...), self$transform))
    },

    #' Apply 'mutate' method to an aggregated data frame.
    #' @param grouped_data a 'grouped_df' object
    #' @param ... Symbol representations of variables in 'data'
    group_mutate = function(grouped_data, ...){
      f <- function(data, group){
        data %>% self$mutate(...)
      }
      grouped_data %>% group_modify(f)
    },

    #' Aggregate a data frame and apply 'mutate' to each.
    #' @param data A data frame to be manipulated
    #' @param grp_cols Vector of variables in 'data' to group on.
    #' @param mutate_cols Vector of variables in 'data' to transform.
    group_and_mutate = function(data, grp_cols, mutate_cols){

      grouped_data <- group_by(data, across({{ grp_cols }}))
      self$group_mutate(grouped_data, {{ mutate_cols }})
    },

    serialize = function(type=class(self), on_init=list(), dots=list()){
      list(Type=type[1], OnInit=on_init, Dots=dots)
    },

    str = function(...){
      glue("{class(self)[1]}")
    }
  )
)

overlap <- function(data, ...){
  .dots <- dots_as_labels(...)
  .cols <- colnames(data)

  intersect(.cols, .dots)
}
