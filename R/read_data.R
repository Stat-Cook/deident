read_data <- function(file_path, ...){
  #' @export
  UseMethod("read_data")
}

read_data.csv_path <- function(file_path, ...){
  #' @exportS3Method
  frm <- read.csv(file_path, check.names = F, ...)
  fix_colnames(frm)
}

read_data.xls_path <- function(file_path, ...){
  #' @importFrom readxl read_xls
  #' @exportS3Method
  readxl::read_excel(file_path, ...)
}

read_data.xlsx_path <- function(file_path, ...){
  #' @importFrom readxl read_xls
  #' @exportS3Method
  readxl::read_excel(file_path, ...)
}

read_data.tsv_path <- function(file_path, ...){
  #' @exportS3Method
  frm <- read.csv(file_path, sep = "\t", check.names = F, ...)
  fix_colnames(frm)
}
