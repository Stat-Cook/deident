test_that("pseudonymizer methods", {
  expect_equal(null.method(1), 1)
  expect_equal(null.method("A"), "A")

  .l <- list(A = 1, B = 2, C = 3)

  expect_equal(get.f("A", .l), 1)
  expect_equal(get.f("C", .l), 3)
  expect_equal(get.f("NA", .l), NULL)

  expect_equal(
    length(add.f(.l, "E")),
    4
  )

  expect_equal(
    length(add.f(.l, 6)),
    4
  )
})

test_that("pseudonymizer internals", {
  psu <- Pseudonymizer$new()
  psu$transform(ShiftsWorked$Employee)

  expect_true(all(
    psu$exists(ShiftsWorked$Employee)
  ))

  .lookup <- psu$get_lookup()

  expect_equal(
    class(.lookup)[3],
    "data.frame"
  )

  .ser <- psu$serialize()

  expect_equal(
    length(.ser$args$lookup),
    nrow(.lookup)
  )
})
