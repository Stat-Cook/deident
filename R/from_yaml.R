add_deident <- function(dlist, to_add){
  vars <- labels_as_symbols(to_add$variables)
  
  dlist$add_method(to_add$Type, !!!vars, !!!to_add$args)
  
  dlist
}


from_yaml <- function(path, data=NULL){
  #' @importFrom yaml read_yaml
  yml <- read_yaml(path)
  deident(yml)
}


