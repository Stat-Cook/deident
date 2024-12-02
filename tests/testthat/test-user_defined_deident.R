test_that("UserDefinedDeident works", {
  method <- function(vec) {
    rep("", length(vec))
  }

  udd <- UserDefinedDeident$new(method)
  .vec <- udd$transform(letters)

  expect_equal(
    .vec,
    rep("", 26)
  )

  udd2 <- deident_from_func(method)
  .vec2 <- udd2$transform(letters)

  expect_equal(
    .vec2,
    rep("", 26)
  )
})
