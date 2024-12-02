encrypt_256 <- function(values, key, seed) {
  #' @importFrom openssl sha256
  seeded_values <- paste(values, seed, sep = "")
  sha256(seeded_values, key = key)
}


#' Deidentifier class for applying 'encryption' transform
#'
#' 'Encrypting' refers to the cryptographic hashing  of data e.g. md5
#' checksum.  Encryption is more powerful if a random hash and seed are
#' supplied and kept secret.
#'
#' @export
Encrypter <- R6Class(
  "Encrypter", list(
    #' @field hash_key Alpha-numeric secret key for encryption
    hash_key = NA,

    #' @field seed String for concatenation to raw value
    seed = NA,

    #' @description
    #' Create new Encrypter object
    #' @param hash_key An alpha numeric key for use in encryption
    #' @param seed An alpha numeric key which is concatenated to
    #'     minimize brute force attacks
    #' @return `Encrypter`
    initialize = function(hash_key = "", seed = NA) {
      self$hash_key <- hash_key
      self$seed <- seed
      self$method <- function(values) {
        encrypt_256(values, self$hash_key, self$seed)
      }
    },

    #' Apply blur to a vector of values
    #' @param keys Vector of values to be processed
    #' @param ... Values to be concatenated to keys
    transform = function(keys, ...) {
      keys <- c(keys, ...)
      self$method(keys)
    },

    #' @description
    #' `r serialize.desc()`
    serialize = function() {
      super$serialize(hash_key = self$hash_key, seed = self$seed)
    }
  ),
  inherit = BaseDeident
)
