test_that("BaseDeident works", {
  #' @importFrom checkmate expect_data_frame expect_character
  .tra <- BaseDeident$new()
  expect_identical(.tra$transform(1:10), 1:10)

  .tra$set_method(function(i) rep(0, length(i)))
  expect_identical(.tra$transform(1:10), rep(0, 10))

  n <- 50
  df <- data.frame(A = 1:10, B = sample(LETTERS[1:4], n, T))

  .mut <- .tra$mutate(df, A)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)

  .mut <- .tra$group_and_mutate(df, B, A)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)
})
