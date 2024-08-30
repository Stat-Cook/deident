test_that("BaseDotDeident works", {
  bdd <- BaseDotDeident$new()
  
  .f <- function(...){
    enquos(...)
  }

  quo <- .f(x, y, z)
  
  .serialize <- bdd$serialize(quo)
  
  expect_equal(
    length(.serialize$args), 
    3
  )
  
})
