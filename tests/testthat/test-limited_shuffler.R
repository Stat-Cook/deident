n <- 40
set.seed(101)
df <- data.frame(
  A = sample(LETTERS[1:4], n, T),
  B = rnorm(n)
)
df[40,1] <- "E"

.tra <- LimitedShuffler$new()

test_that("LimitedShuffler works", {

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
  shuffled <- .tra$group_and_mutate(df, A, B)

  E <- filter(shuffled, A == "E")

  expect_true(is.na(E$B))
})
