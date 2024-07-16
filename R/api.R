pseudonymize <- function(object, ..., encrypter=Pseudonymizer, init.list=list()){
  #' @export
  deident(object, {{encrypter}}, ..., init.list=init.list)
}

shuffle <- function(object, ..., encrypter=Shuffler, init.list=list()){
  #' @export
  deident(object, {{encrypter}}, ..., init.list=init.list)
}

shuffle_in_group <- function(data, grp_cols, ...){
  #' @export
  shuf <- Shuffler$new()
  shuf$group_and_mutate(
    data, {{grp_cols}}, c(...)
  )
}


encrypt <- function(object, ..., encrypter=Encrypter, init.list=list()){
  #'
  deident(object, {{encrypter}}, ..., init.list=init.list)
}

perturb <- function(object, ..., encrypter=Perturber, init.list=list()){
  #'
  deident(object, {{encrypter}}, ..., init.list=init.list)
}

