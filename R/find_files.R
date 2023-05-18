#methods(read_data)

get_implemented_extensions <- function(){
  #' @importFrom stringr str_remove
  methods <- methods("read_data")
  methods <- stringr::str_remove(methods, "^read_data.")

  stringr::str_remove(methods, "_path$")
}

find_files <- function(path,
                       extensions=get_implemented_extensions(),
                       .lis=list()){
  #' @importFrom purrr reduce

  dirs <- list.dirs(path, recursive = F)

  if (length(dirs)){
    for (dir in dirs){
      .lis <- find_files(dir, extensions, .lis)
    }
  }

  file.paths <- lapply(
    extensions,
    list_files_by_extension,
    path
  )

  .lis <- append(file.paths, list(.lis), after=0)

  purrr::reduce(.lis, append)

}

set_class <- function(i, .class){
  class(i) <- .class
  i
}

list_files_by_extension <- function(extension, path="."){
  #' @importFrom glue glue
  pattern <- glue::glue(".{extension}$")
  .class <- glue::glue("{extension}_path")

  fp <- list.files(path, pattern=pattern, full.names = T)

  lapply(fp, set_class, .class)
}
