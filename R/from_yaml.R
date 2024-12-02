add_deident <- function(dlist, to_add) {
  vars <- labels_as_symbols(to_add$variables)

  dlist$add_method(to_add$Type, !!!vars, !!!to_add$args)

  dlist
}


#' Restore a serialized deident from file
#'
#' @param path Path to serialized deident.
#'
#' @export
#'
#' @examples
#'
#' deident <- deident(ShiftsWorked, Pseudonymizer, Employee)
#' .tempfile <- tempfile(fileext = ".yml")
#' deident$to_yaml(.tempfile)
#'
#' deident.yaml <- from_yaml(.tempfile)
#' deident.yaml$mutate(ShiftsWorked)
#'
#' @importFrom yaml read_yaml
from_yaml <- function(path) {
  yml <- read_yaml(path)
  deident(yml)
}
