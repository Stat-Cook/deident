test_that("error_reduce", {
  
  expect_equal(
    error_reduce(1:10, sum),
    55
  )
  
  .vec <- replicate(5, sample(letters, 10), simplify = F)
  
  expect_equal(
    error_reduce(.vec, union),
    reduce(.vec, union)
  )
  
})




