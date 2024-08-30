test_that("Grouper works", {
  grp <- Grouper$new(A, B, C)
  
  .ser <- grp$serialize()
  expect_equal(
    length(.ser$args),
    3
  )
  
  expect_equal(grp$str(), "Grouper(group_on = [A, B, C])")
})
