error_reduce <- function(.x, .f, ...) {
  #' @importFrom rlang abort
  #' @importFrom purrr reduce2
  #' @importFrom utils head

  .i <- head(seq_along(.x), -1)


  error_f <- function(x1, x2, step) {
    tryCatch(
      .f(x1, x2, ...),
      error = function(e) {
        .body <- paste0(e$body, collapse = "\n")
        .message <- e$message

        rlang::abort(
          sprintf(
            "Error at step: %s\n%s\n%s",
            step,
            .message,
            .body
          )
        )
      }
    )
  }

  purrr::reduce2(.x, .i, error_f, ...)
}

DeidentList <- R6Class("DeidentList", list(
  deident_methods = list(),
  data = NULL,
  allowed_values = NULL,
  initialize = function(data = NULL) {
    self$data <- data
    if (!is.null(data)) {
      self$allowed_values <- colnames(data)
    }
  },
  add_method = function(deident, ...) {
    dots <- arg_kwarg(...)

    if (!is.null(self$allowed_values)) {
      check_values(self$allowed_values, dots$args)
    }

    to_add <- create_deident(deident, ...)

    self$deident_methods <- append(
      self$deident_methods,
      list(to_add)
    )
    invisible(self)
  },
  mutate = function(data) {
    #' @importFrom purrr reduce
    .lis <- append(self$deident_methods, list(data), after = 0)
    error_reduce(.lis, deident_list_mutate)
  },
  print = function(...) {
    #' @importFrom glue glue
    cat("DeidentList\n")

    len <- length(self$deident_methods)
    cat("  ", glue("{len} step(s) implemented \n\n"))

    i <- 1
    for (step in self$deident_methods) {
      cat("   Step", i, ":", str(step), "\n")
      i <- i + 1
    }

    if (!is.null(self$data)) {
      data.cols <- paste(self$allowed_values, collapse = ", ")
      cat("For data:\n")
      cat("  ", glue("columns: {data.cols}"))
    }

    invisible(self)
  },
  to_yaml = function(path) {
    #' @importFrom yaml write_yaml
    .lis <- serialize(self)
    yaml::write_yaml(.lis, path)
  }
))


new_deident_list <- function(data = NULL) {
  DeidentList$new(data)
}
