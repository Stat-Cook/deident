#' read_data <- function(file_path, ...){
#'   #' @export
#'   UseMethod("read_data")
#' }

set_path_class <- function(file_path){
  ext <- tolower(tools::file_ext(file_path))

  class(file_path) <- c(glue::glue("{ext}_path"), "path", class(file_path))

  file_path
}

load_file <- function(file_path){
  UseMethod("load_file")
}

load_file.csv_path <- function(file_path, ...){
  readr::read_csv(file_path, ...)
}

load_file.xls_path <- function(file_path, ...){
  openxlsx::read.xlsx(file_path,  ...)
}

load_file.xlsx_path <- function(file_path, ...){
  openxlsx::read.xlsx(file_path,  ...)
}

load_file.tsv_path <- function(file_path, ...){
  readr::read_tsv(file_path,  ...)
}

read_data <- function(file_path, ...){
  file_path <- set_path_class(file_path)

  load_file(file_path, ...)
}

#' read_data.csv_path <- function(file_path, ...){
#'   #' @exportS3Method
#'   frm <- read.csv(file_path, check.names = F, ...)
#'   fix_colnames(frm)
#' }
#'
#' read_data.xls_path <- function(file_path, ...){
#'   #' @importFrom readxl read_xls
#'   #' @exportS3Method
#'   readxl::read_excel(file_path, ...)
#' }
#'
#' read_data.xlsx_path <- function(file_path, ...){
#'   #' @importFrom readxl read_xls
#'   #' @exportS3Method
#'   readxl::read_excel(file_path, ...)
#' }
#'
#' read_data.tsv_path <- function(file_path, ...){
#'   #' @exportS3Method
#'   frm <- read.csv(file_path, sep = "\t", check.names = F, ...)
#'   fix_colnames(frm)
#' }
