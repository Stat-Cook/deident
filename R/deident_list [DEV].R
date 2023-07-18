DeidentList <- R6Class("DeidentList", list(
  deident_methods = list(),
  data = NULL,
  allowed_values = NULL,

  initialize  = function(data = NULL){
    self$data = data
    if (!is.null(data)){
      self$allowed_values <- colnames(data)
    }
  },

  add_method = function(deident, ..., init.list=list()){
    if (!is.null(self$allowed_values)){
      check_values(self$allowed_values, ...)
    }

    to_add <- create_deident(deident, ..., init.list=init.list)

    self$deident_methods <- append(
      self$deident_methods,
      list(to_add)
    )
    invisible(self)
  },

  mutate = function(data){
    #' @importFrom purrr reduce
    .lis <- append(self$deident_methods, list(data), after = 0)
    purrr::reduce(.lis, deident_list_mutate)
  },

  print = function(...){
    #' @importFrom glue glue
    cat("DeidentList\n")

    len <- length(self$deident_methods)
    cat("  ", glue("{len} step(s) implemented \n\n"))

    i <- 1
    for (step in self$deident_methods){
      cat("   Step", i, ":", str(step), "\n")
      i <- i + 1
    }

    if (!is.null(self$data)){
      data.cols <- paste(self$allowed_values, collapse=", ")
      cat("For data:\n")
      cat("  ", glue("columns: {data.cols}"))
    }

    invisible(self)
  },
  to_yaml = function(path){
    #' @importFrom yaml write_yaml
    .lis <- serialize(self)
    yaml::write_yaml(.lis, path)
  }
))


new_deident_list <- function(data=NULL){
  DeidentList$new(data)
}

