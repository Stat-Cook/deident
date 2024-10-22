#' GroupedShuffler class for applying 'shuffling' transform with data
#'   aggregated
#'
#' 'Shuffling' refers to the a random sampling of a variable without
#' replacement e.g. \[A, B, C\] becoming \[B, A, C\] but not \[A, A, B\].  "Grouped
#' shuffling" refers to aggregating the data by another feature before applying
#' the shuffling process.  Grouped shuffling will preserve aggregate level
#' metrics (e.g. mean, median, mode) but removes ordinal properties
#' i.e. correlations and auto-correlations
#'
#' @param limit Minimum number of rows required to shuffle data
#'
#' @export
GroupedShuffler <- R6Class(

  "GroupedShuffler", list(
    #' @field group_on Symbolic representation of grouping variables
    group_on = NA,

    #' @field limit Minimum number of rows required to shuffle data
    limit = 0,

    #' Create new GroupedShuffler object
    #' @param ... \[optional\] The columns of the to-be supplied data set to
    #' aggregate on.
    initialize = function(..., limit=0){
      self$group_on <- enquos(...)
      self$set_method(sample)
      self$set_limit(limit)
    },

    #' Aggregate a data frame and apply 'mutate' to each.
    #' @param data A data frame to be manipulated
    #' @param ... Vector of variables in 'data' to transform.
    mutate = function(data, ...){
      group_by(data, !!!self$group_on) %>%
        group_modify(private$group_mutate, ...)
    },

    #' @description 
    #' `r serialize.desc()`
    serialize = function(){
      super$serialize(dots = dots_as_labels(!!!self$group_on))
    },

    #' @description 
    #' Character representation of the class
    str = function(){
      labels <- quosure_as_labels(self$group_on)
      super.str <- super$str()
      glue("{super.str}(group_on={paste(labels, collapse=', ')})")
    }
  ),
  private = list(
    group_mutate = function(data, groups, ...){
      if (nrow(data) <= self$limit){
        null.func <- function(i) rep(NA, length(i))
        return(
          mutate(data, across(c(...), null.func))
        )
      }

      if (nrow(data) == 1){
        return(data)
      }

      mutate(data, across(c(...), self$method))
    }
  ),
  inherit = Shuffler
)


