root <- "Test_files"
dir.create(root)
file.extensions <- c("csv", "xls", "xlsx")
paths <- c()

q <- 10

for (ext in file.extensions) {
  dir.create(file.path(root, ext))
  for (i in seq_len(q)) {
    file <- glue::glue("Test {i}.{ext}")
    fp <- file.path("Test_files", ext, file)

    readr::write_excel_csv(data.frame(), fp)
  }
}

.files <- find_files("Test_files", file.extensions)

unlink("Test_files", recursive = TRUE)

expect_true(length(.files) == 30)

.classes <- sapply(.files, class)
expect_true(
  all(.classes %in% c("csv_path", "xls_path", "xlsx_path"))
)
