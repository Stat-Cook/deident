test_that("init.list.f", {
  
  new.list <- init.list.f(
    list(1,2,3), list(A=3, B=4, C=5)
  )
  
  expect_equal(
    length(new.list),
    6
  )  
})

test_that("squash_map ", {
    
  .f <- function(...){
    enquos(...)
  }
  
  x <- .f(A, B, C)
  squashed <- squash_map(x)  
  
  all(map(squashed, class) == "name")
  expect_equal(
    length(squashed),
    3
  )
  
  expect_true(
    all(map(squashed, class) == "name")
  )
    
})
