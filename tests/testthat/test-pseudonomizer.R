test_that("Psudonomizer works", {
  n <- 40
  df <- data.frame(
    A = sample(LETTERS[1:4], n, T),
    B = rnorm(n)
  )

  .tra <- Pseudonymizer$new()

  expect_character(.tra$transform(df$A))
  expect_equal(length(.tra$transform(df$A)), n)

  expect_warning(.tra$transform(df$B))

  .mut <- .tra$mutate(df, A)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)

  expect_warning(.tra$mutate(df, B))
  expect_data_frame(
    suppressWarnings(.tra$mutate(df, B))
  )
})
