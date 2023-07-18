DeidentJob <- R6::R6Class(
  "DeidentJob",
  list(
    raw_dir = NULL,
    result_dir = NULL,
    initialize = function(raw_dir, result_dir="Deident_results"){

      if (!dir.exists(raw_dir)){
        warning(glue::glue("Directory {raw_dir} doesn't exist."))
      }
      self$raw_dir = raw_dir

      if (!dir.exists(result_dir)){
        dir.create(result_dir)
      }
      self$result_dir = result_dir
    },
    list.files = function(){
      list.files(self$raw_dir)
    },
    apply_deident = function(deident){
      .files <- self$list.files()
      for (.file in .files){
        file.path <- file.path(self$raw_dir, .file)
        converted_data <- apply_deident(file.path, deident)

        ext <- tools::file_ext(.file)

        .base <- basename(.file)
        .base <- stringr::str_replace(.base, ext, "csv")
        # All files exported as csv.
        # TODO: consider making this more flexible.
        result_path <- file.path(self$result_dir, .base)

        readr::write_excel_csv(converted_data, result_path)

      }
    }
  )
)

deident_job_from_folder <- function(deident_pipeline,
                                    data_dir,
                                    result_dir="Deident_results"){
  #' @export

  dj <- DeidentJob$new(data_dir, result_dir)
  dj$apply_deident(deident_pipeline)
}

