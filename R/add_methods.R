add_encrypt <- function(object, ..., hash_key = '', seed = NA){
  #'
  enc <- Encrypter$new(hash_key = hash_key, seed = seed)
  deident(object, enc, ...)
}

add_blur <- function(object, ..., blur){
  #'
  blurer <- Blurer$new(blur = blur)
  deident(object, blurer, ...)
}

add_shuffle <- function(object, ..., limit=0){
  shuf <- Shuffler$new(limit = limit)
  deident(object, shuf, ...)
}

add_grouped_shuffle <- function(object, ..., group_on=c(), limit=0){

  group_on <- labels_as_symbols(group_on)
  gs <- GroupedShuffler$new(!!!group_on)
  gs$set_limit(limit)
  deident(object, gs, ...)
}
# class(gs)
#
# serialize.BaseDeident
# gs$serialize()
#
# shuf <- Shuffler$new()
# base <- BaseDeident$new()
# base$serialize
# shuf$serialize

# gs <- LimitedGroupedShuffler$new(A, B)
# gs$serialize()

add_numeric_blur <- function(object, ..., cuts=0){
  nb <- NumericBlurer$new(cuts = cuts)

}
