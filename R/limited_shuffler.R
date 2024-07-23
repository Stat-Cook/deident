LimitedShuffler <- R6Class(

  "LimitedShuffler", list(
  initialize = function(..., limit=1){
    super$initialize(...)
    self$set_limit(limit)
  }),
  inherit = Shuffler
)


LimitedGroupedShuffler <- R6Class(
  "LimitedGroupedShuffler", list(
  initialize = function(..., limit=1){
    super$initialize(...)
    self$set_limit(limit)
  }),
  inherit = GroupedShuffler
)

limited_shuffle_in_group <- function(data, grp_cols, ...){
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
