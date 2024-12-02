n <- 40

int.vec <- sample(1:8, n, T)
rnorm.vec <- rnorm(n)
str.vec <- sample(LETTERS[1:4], n, T)

test_that("apply_transformer.default fails", {
  expect_error(apply_transformer(int.vec, mean))
})

test_that("apply_transformer.BaseDeident methods", {
  psu <- Pseudonymizer$new()
  shuf <- Shuffler$new()
  enc <- Encrypter$new()
  pert <- Perturber$new()
  blur <- Blurrer$new(list(A = "Up", B = "Up", C = "Down"))
  num.blur <- NumericBlurrer$new(cuts = c(-2, 0, 2))

  expect_length(apply_transformer(str.vec, psu), n)
  expect_length(apply_transformer(str.vec, shuf), n)
  expect_length(apply_transformer(str.vec, enc), n)
  expect_length(apply_transformer(str.vec, blur), n)

  expect_length(apply_transformer(rnorm.vec, pert), n)
  expect_length(apply_transformer(rnorm.vec, pert), n)
})


test_that("apply_transformer.character methods", {
  expect_length(apply_transformer(str.vec, "Pseudonymizer"), n)
  expect_length(apply_transformer(str.vec, "psudonymize"), n)

  expect_length(apply_transformer(str.vec, "Shuffler"), n)
  expect_length(apply_transformer(str.vec, "shuffle"), n)

  expect_length(apply_transformer(str.vec, "Encrypter"), n)
  expect_length(apply_transformer(str.vec, "encrypt"), n)

  expect_length(apply_transformer(int.vec, "Perturber"), n)
  expect_length(apply_transformer(int.vec, "perturb"), n)

  expect_length(apply_transformer(str.vec, "Blurrer"), n)
  expect_length(apply_transformer(str.vec, "blur"), n)

  expect_length(apply_transformer(int.vec, "NumericBlurrer"), n)
  expect_length(apply_transformer(int.vec, "numeric_blur"), n)
})
