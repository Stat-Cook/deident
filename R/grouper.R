Grouper <- R6Class(
  "Grouper",
  list(
    group_on = NA,
    initialize = function(...) {
      self$group_on <- enquos(...)
    },
    mutate = function(data, ...) {
      data %>%
        dplyr::group_by(!!!self$group_on)
    },
    serialize = function() {
      super$serialize(self$group_on)
    },
    str = function() {
      super.str <- super$str()
      group_by <- simplify(map(self$group_on, rlang::quo_squash))
      group_by.str <- paste(group_by, collapse = ", ")
      glue("{super.str}(group_on = [{group_by.str}])")
    }
  ),
  inherit = BaseDotDeident
)

class(Grouper) <- c("GrouperR6ClassGenerator", "R6ClassGenerator")

Ungrouper <- R6Class(
  "Ungrouper",
  list(
    mutate = function(data, ...) {
      dplyr::ungroup(data)
    }
  ),
  inherit = BaseDeident
)
