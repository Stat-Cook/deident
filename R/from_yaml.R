add_deident <- function(dlist, to_add){
  init.list <- init.list.f(to_add$OnInit, to_add$Dots)
  vars <- labels_as_symbols(to_add$Variables)

  dlist$add_method(to_add$Type, !!!vars, init.list=init.list)

  dlist
}

from_yaml <- function(path, data=NULL){
  yml <- yaml::read_yaml(path)
  deident(yml)
}
