test_that("noise tests", {
  set.seed(999)
  .vec <- rnorm(100)
  
  expect_true(
    all(white_noise(0.1)(.vec) != .vec)
  )
  
  expect_true(
    all(lognorm_noise(0.1)(.vec) != .vec)
  )
  
  expect_true(
    all(adaptive_noise(0.1)(.vec) != .vec)
  )


})

test_that("Perturber init",{
  set.seed(999)
  .vec <- rnorm(100)
  
  pert <- Perturber$new()
  p2 <- initialize.pertuber.character("white_noise(0.32)", pert)
  
  expect_equal(p2$noise.str, "white_noise(0.32)")
  
  expect_true(
    all(p2$transform(.vec) != .vec)
  )
  
  .ser <- pert$serialize()
  expect_equal(.ser$args$noise, "white_noise(0.32)")
  
  expect_equal(
    pert$str(),
    "Perturber(white_noise(0.32))"
  )
  
})
