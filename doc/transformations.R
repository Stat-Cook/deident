## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(deident)

## ---- include=F---------------------------------------------------------------
df <- data.frame(
  A = letters, 
  B = 1:26, 
  C = sort(rep(c("X", "Y"), 13))
)
df

## ---- eval=F------------------------------------------------------------------
#  deident(df, "psudonymize", A)
#  deident(df, "Pseudonymizer", A)
#  deident(df, Pseudonymizer, A)
#  deident(df, Pseudonymizer$new(), A)
#  
#  psu <- Pseudonymizer$new()
#  deident(df, psu, A)

## -----------------------------------------------------------------------------
psu <- Pseudonymizer$new()

new_method <- function(key, ...){
  paste(sample(letters, 12, T), collapse="")
}

psu$set_method(new_method)

deident(df, psu, A)

## ---- eval=F------------------------------------------------------------------
#  deident(df, "shuffle", A)
#  deident(df, "Shuffler", A)
#  deident(df, Shuffler, A)
#  deident(df, Shuffler$new(), A)
#  
#  shuffle <- Shuffler$new()
#  deident(df, shuffle, A)

## ---- eval=F------------------------------------------------------------------
#  deident(df, "encrypt", A)
#  deident(df, "Encrypter", A)
#  deident(df, Encrypter, A)
#  deident(df, Encrypter$new(), A)
#  
#  encrypt <- Encrypter$new()
#  deident(df, encrypt, A)

## -----------------------------------------------------------------------------
encrypt <- Encrypter$new(hash_key="deident_hash_key_123", seed=202)
deident(df, encrypt, A)

## ---- eval=F------------------------------------------------------------------
#  deident(df, "perturb", A)
#  deident(df, "Perturber", A)
#  deident(df, Perturber, A)
#  deident(df, Perturber$new(), A)
#  
#  perturb <- Perturber$new()
#  deident(df, perturb, A)

## -----------------------------------------------------------------------------
perturb <- Perturber$new(sd=5)
deident(df, perturb, B)

## ---- eval=F------------------------------------------------------------------
#  letter_blur <- c(rep("Early", 13), rep("Late", 13))
#  names(letter_blur) <- letters
#  
#  blur <- Blurer$new(blur = letter_blur)
#  deident(df, blur, A)

## ---- eval=F------------------------------------------------------------------
#  deident(df, "numeric_blur", B)
#  deident(df, "NumericBlurer", B)
#  deident(df, NumericBlurer, B)
#  deident(df, NumericBlurer$new(), B)
#  
#  numeric_blur <- NumericBlurer$new()
#  deident(df, numeric_blur, B)

## -----------------------------------------------------------------------------
numeric_blur <- NumericBlurer$new(cuts=c(5, 10, 15, 20))
deident(df, numeric_blur, B)

## ---- eval=F------------------------------------------------------------------
#  grouped_shuffle <- GroupedShuffler$new(C)
#  deident(df, grouped_shuffle, B)

## -----------------------------------------------------------------------------
numeric_blur <- GroupedShuffler$new(C, limit=1)
deident(df, numeric_blur, B)

## ---- eval=F------------------------------------------------------------------
#  
#  deident(df, Drop, B)
#  
#  drop <- deident:::Drop$new()
#  deident(df, drop, B)

