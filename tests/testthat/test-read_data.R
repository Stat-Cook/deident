test_that("set_path_class works", {
  new.path <- set_path_class("bob/temp.csv")
  expect_true("csv_path" %in% class(new.path))

  new.path <- set_path_class("bob/temp.tsv")
  expect_true("tsv_path" %in% class(new.path))
})

test_that("load_file works", {
  file.csv <- set_path_class("test_data/ShiftsWorked.csv") |>
    load_file()

  expect_true(
    nrow(file.csv) > 0
  )

  file.tsv <- set_path_class("test_data/ShiftsWorked.tsv") |>
    load_file()

  expect_true(
    nrow(file.tsv) > 0
  )

  file.xlsx <- set_path_class("test_data/ShiftsWorked.xlsx") |>
    load_file()

  expect_true(
    nrow(file.xlsx) > 0
  )
})
