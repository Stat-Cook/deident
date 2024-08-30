test_that("numeric blur", {
  .fn <- numeric_blur.f(c(-2, 2)) 
  
  expect_equal(class(.fn), "function")
  
  result <- .fn(-10:10)
  
  expect_equal(class(result), "factor")

  expect_equal(levels(result), c("(-Inf,-2]", "(-2,2]", "(2, Inf]"))
})
