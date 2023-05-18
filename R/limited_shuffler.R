LimitedShuffler <- R6Class(
  #' @export
  "LimitedShuffler", list(
  initialize = function(...){
    super$initialize(...)
    self$set_limit(1)
  }),
  inherit = Shuffler
)


LimitedGroupedShuffler <- R6Class(
  #' @export
  "LimitedGroupedShuffler", list(
  initialize = function(...){
    super$initialize(...)
    self$set_limit(1)
  }),
  inherit = GroupedShuffler
)

limited_shuffle_in_group <- function(data, grp_cols, ...){
  #' @export
  #' @importFrom tidyselect eval_select
  #' @importFrom rlang enquo sym

  cols <- eval_select(
    enquo(grp_cols),
    data = data
  )
  grp_cols_list <- lapply(names(cols), sym)

  lgs <- LimitedGroupedShuffler$new(!!!grp_cols_list)

  lgs$mutate(data, ...)
}