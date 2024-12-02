test_that("Blurrer works", {
  #' @importFrom checkmate expect_character expect_data_frame
  n <- 40
  df <- data.frame(
    A = sample(LETTERS[1:4], n, T),
    B = rnorm(n)
  )

  blur <- list(A = "Up", B = "Down")
  .tra <- Blurrer$new(blur)

  expect_character(.tra$transform(df$A))
  expect_equal(length(.tra$transform(df$A)), n)

  .mut <- .tra$mutate(df, A)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)
})
