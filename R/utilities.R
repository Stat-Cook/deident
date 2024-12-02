dots_as_labels <- function(...) {
  enq <- enquos(...)
  sapply(enq, as_label)
}

quosure_as_labels <- function(quosure) {
  #' @importFrom rlang as_label
  sapply(
    quosure,
    rlang::as_label
  )
}

labels_as_symbols <- function(labels) {
  lapply(labels, as.symbol)
}



serialize.BaseDeident <- function(x, ...) {
  #' @exportS3Method
  x$serialize()
}

serialize.DeidentTask <- function(x, ...) {
  #' @exportS3Method
  method.list <- serialize(x$method)
  variables <- quosure_as_labels(x$variables)

  append(method.list, list(variables = variables))
}

serialize.DeidentList <- function(x, ...) {
  #' @exportS3Method

  map(x$deident_methods, serialize)
}

check_values <- function(allowed_values, quos,
                         msg_template = "Column(s) {cols} not present in data") {
  #' @importFrom glue glue

  quos.labels <- unlist(lapply(quos, rlang::as_label))

  not_present <- quos.labels[!quos.labels %in% allowed_values]

  if (length(not_present)) {
    cols <- paste(not_present, sep = ", ")
    msg <- glue(msg_template)
    warning(msg)
  }
}


deident_list_mutate <- function(data, deident_vars) {
  deident_vars$method$mutate(data, !!!deident_vars$variables)
}

#
# fix_colnames <- function(frm, pattern="V{.x}"){
#   .cols <- colnames(frm)
#
#   fix_index <- which((.cols == "") | (length(.cols) == 0))
#   .x <- 1
#
#   for (index in fix_index){
#     proposal <- glue(pattern)
#     while (proposal %in% .cols){
#       .x <- .x + 1
#       proposal <- glue(pattern)
#     }
#
#     .cols[index] <- proposal
#   }
#
#   colnames(frm) <- .cols
#   frm
# }

init.list.f <- function(on_init = list(), dot.args = list()) {
  append(on_init, dot.args)
}

arg_kwarg <- function(...) {
  .list <- rlang::enquos(...)

  list(
    args = .list[names(.list) == ""],
    kwargs = .list[names(.list) != ""]
  )
}

squash_map <- function(x) {
  map(x, rlang::quo_squash)
}


unexpected_kwargs <- function(...) {
  dots <- arg_kwarg(...)

  if (length(dots$kwargs) > 0) {
    .names <- names(dots$kwargs)
    .names.str <- paste0("'", .names, "'", collapse = ", ")
    warning(glue::glue(
      "Key-word arguments passed when using pre-initialized deidentifier are ignored. \\
         Options for {.names.str} have been ignored."
    ))
  }
}
