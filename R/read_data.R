set_path_class <- function(file_path) {
  #' @keywords internal
  ext <- tolower(tools::file_ext(file_path))

  class(file_path) <- c(glue::glue("{ext}_path"), "path", class(file_path))

  file_path
}

load_file <- function(file_path) {
  UseMethod("load_file")
}

load_file.csv_path <- function(file_path, ...) {
  #' @importFrom readr read_csv
  read_csv(file_path, ...)
}

load_file.xls_path <- function(file_path, ...) {
  #' @importFrom openxlsx read.xlsx
  read.xlsx(file_path, ...)
}

load_file.xlsx_path <- function(file_path, ...) {
  #' @importFrom openxlsx read.xlsx
  read.xlsx(file_path, ...)
}

load_file.tsv_path <- function(file_path, ...) {
  #' @importFrom readr read_tsv
  read_tsv(file_path, ...)
}

read_data <- function(file_path, ...) {
  file_path <- set_path_class(file_path)

  load_file(file_path, ...)
}
