implemented_transforms_base.f <- function(user_defined = list()) {
  base <- list(
    "Pseudonymizer" = Pseudonymizer,
    "Shuffler" = Shuffler,
    "Encrypter" = Encrypter,
    "Perturber" = Perturber,
    "Blurer" = Blurer,
    "NumericBlurer" = NumericBlurer,
    "GroupedShuffler" = GroupedShuffler,
    "Drop" = Drop,
    "Tidyer" = Tidyer,
    "Mutater" = Mutater,
    "Grouper" = Grouper,
    "Ungrouper" = Ungrouper,
    "psudonymize" = Pseudonymizer,
    "shuffle" = Shuffler,
    "encrypt" = Encrypter,
    "perturb" = Perturber,
    "blur" = Blurer,
    "numeric_blur" = NumericBlurer,
    "grouped_shuffle" = GroupedShuffler,
    "droper" = Drop,
    "tidy" = Tidyer,
    "mutate" = Mutater,
    "group" = Grouper,
    "ungroup" = Ungrouper
  )
  append(base, user_defined)
}

apply_transformer <- function(values, transformer) {
  UseMethod("apply_transformer", transformer)
}


apply_transformer.BaseDeident <- function(values, transformer) {
  return(transformer$transform(values))
}

apply_transformer.R6 <- function(values, transformer) {
  return(transformer$transform(values))
}

apply_transformer.R6ClassGenerator <- function(values, transformer, ...) {
  .tra <- transformer$new(...)
  return(.tra$transform(values))
}

apply_transformer.character <- function(values, transformer) {
  implemented_transforms <- implemented_transforms_base.f()

  if (transformer %in% names(implemented_transforms)) {
    .transformer <- implemented_transforms[[transformer]]$new()
    return(.transformer$transform(values))
  }
  return(values)
}
