test_that("doctemplates works", {

  expect_equal(class(serialize.desc()), "character")
  
  expect_equal(class(transform.desc()), "character")
})
