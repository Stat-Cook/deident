n <- 40
set.seed(101)
df <- data.frame(
  A = sample(LETTERS[1:4], n, T),
  B = rnorm(n)
)

.tra <- Shuffler$new()

test_that("Shuffler works", {
  expect_character(.tra$transform(df$A))
  expect_equal(length(.tra$transform(df$A)), n)

  expect_numeric(.tra$transform(df$B))
  expect_equal(length(.tra$transform(df$B)), n)

  .mut <- .tra$mutate(df, A)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)

  .mut <- .tra$mutate(df, B)
  expect_data_frame(.mut)
  expect_equal(nrow(.mut), n)
})

test_that("Grouped Shuffler works", {
  #' @importFrom dplyr summarize
  shuffled <- .tra$group_and_mutate(df, A, B)

  shuffled.ave <- group_by(shuffled, A) %>% summarize(Ave = mean(B))
  df.grp <- group_by(df, A)
  df.ave <- summarize(df.grp, Ave = mean(B))

  expect_equal(df.ave$Ave, shuffled.ave$Ave)
})
