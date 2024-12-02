null.method <- function(i) i

exists.f <- function(key, .list) {
  key %in% names(.list)
}

exists <- Vectorize(exists.f, "key")


get.f <- function(key, .list) {
  .list[[key]]
}

get <- function(keys, .list) {
  unlist(.list[keys])
}

add.f <- function(.list, key, method = function(i) i) {
  key.str <- as.character(key)

  .list[[key.str]] <- method(key)
  return(.list)
}

add <- function(keys, .list = list(), method = function(i) i) { # Vectorize(add.f, "key") #, USE.NAMES = FALSE, SIMPLIFY = FALSE)

  .unique.keys <- unique(keys)

  to.create <- setdiff(.unique.keys, names(.list))

  # to.create <- .unique.keys[!.unique.keys %in% names(.list)]

  new_list <- lapply(to.create, method)
  names(new_list) <- to.create

  append(.list, new_list)
}

# persist <- function(item, location){
#   saveRDS(item, location)
# }

key.values <- c(letters, LETTERS, 0:9)

make.key <- function(k = 5) {
  vec <- sample(key.values, k, T)
  paste(vec, collapse = "")
}


method.random <- function(.list) {
  proposal <- make.key()
  while (proposal %in% .list) {
    proposal <- make.key()
  }
  return(proposal)
}

# TODO make accesing the lookup from a pseudonmuizer easier.

#' R6 class for deidentification via replacement
#'
#' @description
#' A `Deident` class dealing with the (repeatable) random replacement of
#' string for deidentification.
#'
#'
#' @param lookup a pre-existing name-value pair to define intended psuedonymizations.
#' Instances of 'name' will be replaced with 'value' on transformation.
#' @param keys Value(s) to be transformed.
#' @param ... Value(s) to concatenate to `keys` and transform
#' @export
#'
Pseudonymizer <- R6Class(
  "Pseudonymizer", list(

    #' @field lookup
    #' list of mapping from key-value on transform.
    lookup = list(),

    #' @description
    #' Create new `Pseudonymizer` object
    initialize = function(lookup = list(), ...) {
      self$initialize_check(...)

      self$lookup <- lookup
      self$method <- function(key) method.random(self$lookup)
    },

    #' @description
    #' Check if a key exists in `lookup`
    #'
    exists = function(keys, ...) {
      keys <- c(keys, ...)
      exists(keys, self$lookup)
    },

    #' @description
    #' Check if a key exists in `lookup`
    #'
    #' @param keys value to be checked
    #' @param ... values to concatenate to `key` and check
    add = function(keys, ...) {
      keys <- c(keys, ...)
      self$lookup <- add(keys, self$lookup, self$method)
    },

    #' @description
    #' Retrieve a value from `lookup`
    #'
    get = function(keys, ...) {
      keys <- c(keys, ...)
      get(keys, self$lookup)
    },

    #' @description
    #' Returns `self$lookup` formatted as a tibble
    #'
    get_lookup = function() {
      tibble(
        Original = names(self$lookup),
        Transformed = simplify(self$lookup)
      )
    },

    #' @description
    #' `r serialize.desc()`
    serialize = function() {
      super$serialize(lookup = self$lookup)
    },

    #' @description
    #' `r transform.desc()`
    #'
    #' @param parse_numerics True: Force columns to characters.  NB: only
    #' character vectors will be parsed.
    transform = function(keys, ..., parse_numerics = T) {
      keys <- c(
        keys,
        ...
      )
      if (parse_numerics) {
        keys <- as.character(keys)
      } else {
        if (!is.character(keys)) {
          warning("Pseudonomizer expects character string - received numeric.
                Column not altered")
          return(keys)
        }
      }

      self$add(keys)
      self$get(keys)
    }
  ),
  inherit = BaseDeident
)
