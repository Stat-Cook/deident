test_that("Tidyer works", {
  
  filter_func <- \(data) filter(data, species == "Human") 
  
  .tidyer <- Tidyer$new(filter_func)

  new.data <- .tidyer$mutate(starwars)
  
  expect_equal(
    unique(new.data$species),
    "Human"
  )
  
  expect_error(.tidyer$serialize())
  
  expect_equal(.tidyer$str(), "Tidyer(fn = filter_func)") 
})
