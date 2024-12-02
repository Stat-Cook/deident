test_that("From class generator", {
  d <-
    create_deident(Pseudonymizer, Employee, lookup = list(Bob = "asjkdha"))

  .vars <- purrr::map(d$variables, rlang::quo_get_expr)

  expect_equal(
    .vars[[1]],
    as.name("Employee")
  )

  expect_equal(
    length(.vars),
    1
  )

  expect_equal(
    d$method$lookup,
    list(Bob = "asjkdha")
  )
})

test_that("From object", {
  psu <- Pseudonymizer$new(lookup = list(Bob = "asjkdha"))

  d <- create_deident(psu, Employee)

  .vars <- purrr::map(d$variables, rlang::quo_get_expr)

  expect_equal(
    .vars[[1]],
    as.name("Employee")
  )

  expect_equal(
    length(.vars),
    1
  )

  expect_equal(
    d$method$lookup,
    list(Bob = "asjkdha")
  )
})

test_that("From character", {
  d <-
    create_deident("Pseudonymizer", Employee, lookup = list(Bob = "asjkdha"))

  .vars <- purrr::map(d$variables, rlang::quo_get_expr)

  expect_equal(
    .vars[[1]],
    as.name("Employee")
  )

  expect_equal(
    length(.vars),
    1
  )

  expect_equal(
    d$method$lookup,
    list(Bob = "asjkdha")
  )
})


test_that("Warning ", {
  dl <- deident(ShiftsWorked)
  psu <- Pseudonymizer$new()
  enc <- Encrypter$new()

  expect_warning(
    deident(dl, psu, Employee, lookup = list(ABC = 2)),
    ".*'lookup'.*"
  )

  expect_warning(
    deident(psu, Employee, lookup = list(ABC = 2)),
    ".*'lookup'.*"
  )

  expect_warning(
    deident(dl, enc, Employee,
      hash_key = "asd", seed =
        123
    ),
    ".*'hash_key', 'seed'.*"
  )

  expect_warning(
    deident(enc, Employee,
      hash_key = "asd", seed =
        123
    ),
    ".*'hash_key', 'seed'.*"
  )
})
