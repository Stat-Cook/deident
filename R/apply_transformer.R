implemented_transforms_base.f <- function(user_defined=list()){
    base <- list("Pseudonymizer" = Pseudonymizer,
         "Shuffler" = Shuffler,
         "Encrypter" = Encrypter,
         "Perturber" = Perturber,
         "Blurer" = Blurer,
         "NumericBlurer" = NumericBlurer,
         "GroupedShuffler" = GroupedShuffler,
         "Drop" = Drop,
         "psudonymize" = Pseudonymizer,
         "shuffle" = Shuffler,
         "encrypt" = Encrypter,
         "perturb" = Perturber,
         "blur" = Blurer,
         "numeric_blur" = NumericBlurer,
         "grouped_shuffle" = GroupedShuffler,
         "droper" = Drop)
    append(base, user_defined)
}

apply_transformer <- function(values, transformer){
  #' @export
  UseMethod ("apply_transformer", transformer)
}


apply_transformer.BaseDeident <- function(values, transformer){
  #' @exportS3Method
  return (transformer$transform(values))
}

apply_transformer.R6 <- function(values, transformer){
  #' @exportS3Method
  return (transformer$transform(values))
}

apply_transformer.R6ClassGenerator <- function(values, transformer, ...){
  #' @exportS3Method
  .tra <- transformer$new(...)
  return (.tra$transform(values))
}

apply_transformer.character <- function(values, transformer){
  #' @exportS3Method
  #'

  implemented_transforms <- implemented_transforms_base.f()

  if (transformer %in% names(implemented_transforms)){
    .transformer <- implemented_transforms[[transformer]]$new()
    return (.transformer$transform(values))
  }
  return(values)
}
