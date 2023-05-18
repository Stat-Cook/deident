test_that("Encrypter works", {
  n <- 40
  df <- data.frame(
    A = sample(LETTERS[1:4], n, T),
    B = rnorm(n)
  )

  blur <- list(A = "Up", B = "Down")
  .tra <- Encrypter$new()

  expect_character(.tra$transform(df$A))
  expect_equal(length(.tra$transform(df$A)), n)

  expect_character(.tra$transform(df$B))
  expect_equal(length(.tra$transform(df$B)), n)

  .mut <- .tra$mutate(df, A)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)

  .mut <- .tra$mutate(df, B)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)
})
