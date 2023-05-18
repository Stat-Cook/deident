# LookupEncrypter


LookupEncrypter <- R6Class("LookupEncrypter",list(
    lookup = c(),
    initialize = function(hash_key='', seed=NA,
                          lookup.keys=c(), lookup.values=c()){
      self$hash_key <- hash_key
      self$seed <- seed

      self$lookup <- lookup.values
      names(self$lookup) <- lookup.keys

      self$method = function(values) {

        values <- as.character(values)

        .uni <- unique(values)
        to_add <- .uni[!.uni %in% names(self$lookup)]

        if (length(to_add)){

          converted <- encrypt_256(to_add, self$hash_key, self$seed)
          names(converted) <- to_add

          self$lookup <- append(self$lookup, converted)
        }

        self$lookup[values]

      }
    },
    key_frame = function(){
      dplyr::tibble(Key = names(self$lookup),
                    Value = self$lookup)
    }
  ),
  inherit = Encrypter
)

# enc <- LookupEncrypter$new()
#
# enc$mutate(frm, Unit)
# unlist(enc$lookup)
#
# data.frame(
#   Key = names(enc$lookup),
#   Value = enc$lookup
# )
# unique(frm$Unit)
