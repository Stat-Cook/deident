null.method <- function(i) i

exists.f <- function(key, .list){
  key %in% names(.list)
}

exists <- Vectorize(exists.f, "key")


get.f <- function(key, .list){
  .list[[key]]
}

get <- function(keys, .list){
  unlist(.list[keys])
}

add.f <- function(.list, key, method = function(i) i){
  .list[[key]] <- method(key)
  return(.list)
}

add <- function(keys, .list=list(), method = function(i) i){# Vectorize(add.f, "key") #, USE.NAMES = FALSE, SIMPLIFY = FALSE)

  .unique.keys <- unique(keys)

  to.create <- setdiff(.unique.keys, names(.list))

  # to.create <- .unique.keys[!.unique.keys %in% names(.list)]

  new_list <- lapply(to.create, method)
  names(new_list) <- to.create

  append(.list, new_list)
}

persist <- function(item, location){
  saveRDS(item, location)
}

key.values <- c(letters, LETTERS, 0:9)

make.key <- function(k=5){
  vec <- sample(key.values, k, T)
  paste(vec, collapse="")
}


method.random <- function(.list){
  proposal <- make.key()
  while (proposal %in% .list){
    proposal <- make.key()
  }
  return(proposal)
}

# TODO make accesing the lookup from a pseudonmuizer easier.

Pseudonymizer <- R6Class(
  #' @export
  "Pseudonymizer", list(
  lookup = list(),
  initialize = function(lookup = list()){
    self$lookup <- lookup
    self$method = function(key) method.random(self$lookup)
  },
  exists = function(keys, ...){
    keys <- c(keys, ...)
    exists(keys, self$lookup)
  },
  add = function(key, ...){
    key <- c(key, ...)
    self$lookup <- add(key, self$lookup, self$method)
  },
  get = function(keys, ...){
    keys <- c(keys, ...)
    get(keys, self$lookup)
  },
  transform = function(keys, ...){
    keys <- c(keys, ...)
    if(!is.character(keys)){
      # warning("Pseudonomizer expects character string - received numeric.
      #         Column not altered")
      # return(keys)
      keys <- as.character(keys)
    }
    self$add(keys)
    self$get(keys)
  }),
  inherit = BaseDeident
)
