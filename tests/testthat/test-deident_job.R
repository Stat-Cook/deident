test_that("DeidentJob from folder", {
  job <- DeidentJob$new("test_data/")

  expect_equal(
    class(job),
    c("DeidentJob", "R6")
  )

  expect_warning(
    DeidentJob$new("Not here")
  )

  pipe <- ShiftsWorked |>
    add_encrypt(Employee)

  job$apply_deident(pipe)
})

test_that("DeidentJob folder doesnt exist", {
  expect_warning(DeidentJob$new("test_data2"))
})
