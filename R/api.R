#' Deidentification API root
#'
#' A general function for defining a deident function.
#'
#' @param object Either a `data.frame`, `tibble`, or existing `DeidentList` pipeline.
#' @param ... variables to be transformed.
#'
#' @importFrom dplyr `%>%`
#'
#' @md
#' @export
#' @keywords internal
#'
#' @return
#' A 'DeidentList' representing the untrained transformation pipeline.
#' The object contains fields:
#'
#' * `deident_methods` a list of each step in the pipeline (consisting of `variables` and `method`)
#'
#' and methods:
#'
#' * `mutate` apply the pipeline to a new data set
#' * `to_yaml` serialize the pipeline to a '.yml' file
#'
new_deident <- function(object, ..., encrypter) {
  deident(object, {{ encrypter }}, ...)
}

#' De-identification via  replacement
#'
#' `add_pseudonymize()` adds a psuedonymization step to a transformation pipeline.
#' When ran as a transformation, terms that have not been seen before are given a new
#' random alpha-numeric string while terms that have been previously transformed
#' reuse the same term.
#'
#'
#' @inherit new_deident params return
#' @param lookup a pre-existing name-value pair to define intended psuedonymizations.
#' Instances of 'name' will be replaced with 'value' on transformation.#'
#'
#' @export
#' @keywords API
#'
#' @examples
#'
#' # Basic usage;
#' pipe.pseudonymize <- add_pseudonymize(ShiftsWorked, Employee)
#' pipe.pseudonymize$mutate(ShiftsWorked)
#'
#' pipe.pseudonymize2 <- add_pseudonymize(ShiftsWorked, Employee,
#'   lookup = list("Kyle Wilson" = "Kyle")
#' )
#' pipe.pseudonymize2$mutate(ShiftsWorked)
#'
add_pseudonymize <- function(object, ..., lookup = list()) {
  new_deident(object,
    ...,
    lookup = {{ lookup }},
    encrypter = Pseudonymizer
  )
}


#' De-identification via random sampling
#'
#' `add_shuffle()` adds a shuffling step to a transformation pipeline.
#' When ran as a transformation, each specified variable undergoes a random sample without
#' replacement so that summary metrics  on a single variable are unchanged, but
#' inter-variable metrics are rendered spurious.
#'
#' @inherit new_deident params return
#' @param limit integer - the minimum number of observations a variable needs to
#' have for shuffling to be performed.  If the variable has length less than `limit`
#' values are replaced with `NA`s.
#'
#' @export
#' @keywords API
#' @seealso
#' [add_group()] for usage under aggregation
#'
#' @examples
#'
#' # Basic usage;
#' pipe.shuffle <- add_shuffle(ShiftsWorked, Employee)
#' pipe.shuffle$mutate(ShiftsWorked)
#'
#' pipe.shuffle.limit <- add_shuffle(ShiftsWorked, Employee, limit = 1)
#' pipe.shuffle.limit$mutate(ShiftsWorked)
#'
add_shuffle <- function(object, ..., limit = 0) {
  #' @export
  new_deident(object,
    ...,
    limit = {{ limit }},
    encrypter = Shuffler
  )
}

#' De-identification via hash encryption
#'
#' `add_encrypt()` adds an encryption step to a transformation pipeline.
#' When ran as a transformation, each specified variable  undergoes replacement
#' via  an encryption hashing function depending on the `hash_key` and `seed` set.
#'
#' @inherit new_deident params return
#' @param hash_key a random alphanumeric key to control encryption
#' @param seed a random alphanumeric to concat to the value being encrypted
#'
#' @export
#' @keywords API
#'
#' @examples
#'
#' # Basic usage; without setting a `hash_key` or `seed` encryption is poor.
#' pipe.encrypt <- add_encrypt(ShiftsWorked, Employee)
#' pipe.encrypt$mutate(ShiftsWorked)
#'
#' # Once set the encryption is more secure assuming `hash_key` and `seed` are
#' # not exposed.
#' pipe.encrypt.secure <- add_encrypt(ShiftsWorked, Employee, hash_key = "hash1", seed = "Seed2")
#' pipe.encrypt.secure$mutate(ShiftsWorked)
#'
add_encrypt <- function(object, ..., hash_key = "", seed = NA) {
  new_deident(object,
    ...,
    hash_key = {{ hash_key }},
    seed = {{ seed }},
    encrypter = Encrypter
  )
}

#' De-identification via random noise
#'
#' `add_perturb()` adds an perturbation step to a transformation pipeline
#' (NB: intended for numeric data).  When ran as a transformation, each
#' specified variable is transformed by the `noise` function.
#'
#' @inherit new_deident params return
## #' @param noise a single-argument function that applies randomness.
#' @param noise a single-argument function that applies randomness.
#' @export
#' @keywords API
#'
#' @seealso [adaptive_noise()], [white_noise()], and [lognorm_noise()]
#'
#' @examples
#'
#' pipe.perturb <- add_perturb(ShiftsWorked, `Daily Pay`)
#' pipe.perturb$mutate(ShiftsWorked)
#'
#' pipe.perturb.white_noise <- add_perturb(ShiftsWorked, `Daily Pay`, noise = white_noise(0.1))
#' pipe.perturb.white_noise$mutate(ShiftsWorked)
#'
#' pipe.perturb.noisy_adaptive <- add_perturb(ShiftsWorked, `Daily Pay`, noise = adaptive_noise(1))
#' pipe.perturb.noisy_adaptive$mutate(ShiftsWorked)
add_perturb <- function(object, ..., noise = adaptive_noise(0.1)) {
  new_deident(object,
    ...,
    noise = {{ noise }},
    encrypter = Perturber
  )
}

#' De-identification via categorical aggregation
#'
#' `add_blur()` adds an bluring step to a transformation pipeline
#' (NB: intended for categorical data).  When ran as a transformation, values
#' are recoded to a lower cardinality as defined by `blur`.
#' #'
#' @inherit new_deident params return
#'
#' @param blur a key-value pair such that 'key' is replaced by 'value' on
#'   transformation.
#'
#' @export
#' @keywords API
#'
#' @seealso [category_blur()] is provided to aid in defining the `blur`
#'
#' @importFrom stringr str_detect

#' @examples
#' .blur <- category_blur(ShiftsWorked$Shift, `Working` = "Day|Night")
#' pipe.blur <- add_blur(ShiftsWorked, `Shift`, blur = .blur)
#' pipe.blur$mutate(ShiftsWorked)
#'
#' @keywords API
add_blur <- function(object, ..., blur = c()) {
  new_deident(object,
    ...,
    blur = {{ blur }},
    encrypter = Blurrer
  )
}


#' De-identification via numeric aggregation
#'
#' `add_numeric_blur()` adds an bluring step to a transformation pipeline
#' (NB: intended for numeric data).  When ran as a transformation, the data is
#' split into intervals depending on the `cuts` supplied of the series
#' \[-Inf, cut.1), \[cut.1, cut.2), ..., \[cut.n, Inf\] where
#' `cuts` = c(cut.1, cut.2, ..., cut.n).
#'
#' @inherit new_deident params return
#'
#' @param cuts The position in which data is to be divided.
#'
#' @export
#' @keywords API
# TOD0: add examples
add_numeric_blur <- function(object, ..., cuts = 0) {
  #'
  new_deident(object,
    ...,
    cuts = {{ cuts }},
    encrypter = NumericBlurrer
  )
}

add_drop <- function(object, ...) {
  #'
  new_deident(object,
    ...,
    encrypter = Drop
  )
}


#' Add aggregation to pipelines
#'
#' `add_group()` allows for the injection of aggregation into the transformation
#'   pipeline.  Should you need to apply a transformation under aggregation (e.g.
#'   `add_shuffle`) this helper creates a grouped `data.frame` as would be done
#'   with [dplyr::group_by()].
#'   The function `add_ungroup()` is supplied to perform the inverse operation.
#'
#' @inherit new_deident params return
#' @param ... Variables on which data is to be grouped.
#'
#' @importFrom dplyr `%>%`
#' @export
#' @keywords API
#'
#'
#' @examples
#' pipe.grouped <- add_group(ShiftsWorked, Date, Shift)
#' pipe.grouped_shuffle <- add_shuffle(pipe.grouped, `Daily Pay`)
#' add_ungroup(pipe.grouped_shuffle, `Daily Pay`)
add_group <- function(object, ...) {
  new_deident(object,
    ...,
    encrypter = Grouper
  )
}

#' @rdname add_group
#' @export
#' @keywords API
add_ungroup <- function(object, ...) {
  new_deident(object,
    ...,
    encrypter = Ungrouper
  )
}

# Add a 'tidyverse' function to the pipeline.
add_tidy <- function(object, ..., fn = \(x) x) {
  new_deident(object,
    ...,
    fn = {{ fn }},
    encrypter = Tidyer
  )
}

# Add a 'tidyverse' mutate to the pipeline.
add_mutate <- function(object, ...) {
  new_deident(object,
    ...,
    encrypter = Mutater
  )
}
