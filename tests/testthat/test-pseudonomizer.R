expect_character <- function(object){
  act <- quasi_label(rlang::enquo(object), arg = "object")

  testthat::expect(
    is.character(act$val),
    sprintf("%s is of type %s, not 'character'", act$lab, act$val)
  )
  
  invisible(act$val)
}

test_that("Psudonomizer works", {
  n <- 40
  df <- data.frame(
    A = sample(LETTERS[1:4], n, T),
    B = rnorm(n)
  )
  
  .tra <- Pseudonymizer$new()
  .tra$transform(df$A)
  df$A
  expect_character(.tra$transform(df$A))
  expect_equal(length(.tra$transform(df$A)), n)
  
  expect_warning(.tra$transform(df$B, parse_numerics=F))

  .mut <- .tra$mutate(df, A)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)

})

