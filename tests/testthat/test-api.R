map <- purrr::map

test_that("new_deident creates DeidentList correctly", {
  psu <- Pseudonymizer$new()

  dlist.1 <- ShiftsWorked |>
    new_deident(Employee, encrypter = psu)

  expect_equal(
    class(dlist.1),
    c("DeidentList", "R6")
  )
  expect_equal(
    length(dlist.1$deident_methods),
    1
  )

  dlist.2 <- new_deident(dlist.1, Shift, encrypter = psu)
  expect_equal(
    length(dlist.2$deident_methods),
    2
  )

  .variables <- dlist.2$deident_methods |>
    map("variables")

  expect_equal(
    length(.variables),
    2
  )
  expect_equivalent(
    map(.variables[[1]], rlang::quo_squash),
    list(as.name("Employee"))
  )
  expect_equivalent(
    map(.variables[[2]], rlang::quo_squash),
    list(as.name("Shift"))
  )
})

test_that("add_pseudonymize anonymizes Employee correctly", {
  pipe <- ShiftsWorked |>
    add_pseudonymize(Employee)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_false(
    any(ShiftsWorked$Employee == new.data$Employee)
  )

  expect_warning(
    pipe_non_var <- add_pseudonymize(ShiftsWorked, Barry)
  )

  expect_equal(
    apply_deident(ShiftsWorked, pipe_non_var),
    ShiftsWorked
  )
})

test_that("add_shuffle shuffles Shift correctly", {
  pipe <- ShiftsWorked |>
    add_shuffle(Shift)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_false(
    all(ShiftsWorked$Shift == new.data$Shift)
  )
})

test_that("add_encrypt encrypts Employee correctly", {
  pipe <- ShiftsWorked |>
    add_encrypt(Employee)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_false(
    any(ShiftsWorked$Employee == new.data$Employee)
  )
})

test_that("add_perturb perturbs Daily Pay correctly", {
  pipe <- ShiftsWorked |>
    add_perturb(`Daily Pay`)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_false(
    any(ShiftsWorked$`Daily Pay` == new.data$`Daily Pay`)
  )
})

test_that("add_numeric_blur blurs Daily Pay correctly", {
  pipe <- ShiftsWorked |>
    add_numeric_blur(`Daily Pay`)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_true(
    all(ShiftsWorked$`Daily Pay` != new.data$`Daily Pay`)
  )
})

test_that("add_drop drops Record ID correctly", {
  pipe <- ShiftsWorked |>
    add_drop(`Record ID`)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_false(
    "Record ID" %in% colnames(new.data)
  )
})

test_that("add_group groups by Shift correctly", {
  pipe <- ShiftsWorked |>
    add_group(Shift)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_true(
    groups(new.data) == "Shift"
  )

  expect_warning(
    pipe_non_var <- ShiftsWorked |>
      add_encrypt(Employee) |>
      add_group(Barry, Peter)
  )

  expect_error(
    apply_deident(ShiftsWorked, pipe_non_var)
  )
})

test_that("add_ungroup ungroups correctly", {
  pipe <- ShiftsWorked |>
    add_group(Shift) |>
    add_ungroup()

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_equal(
    groups(new.data), list()
  )
})

test_that("add_tidy filters data correctly", {
  pipe <- ShiftsWorked |>
    add_tidy(fn = \(x) dplyr::filter(x, Shift == "Day"))

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_true(
    nrow(new.data) != nrow(ShiftsWorked)
  )
})

test_that("add_mutate creates Double Pay correctly", {
  pipe <- ShiftsWorked |>
    add_mutate(`Double Pay` = 2 * `Daily Pay`)

  new.data <- ShiftsWorked |>
    apply_deident(pipe)

  expect_true(
    all(new.data$`Double Pay` == 2 * ShiftsWorked$`Daily Pay`)
  )
})


# test_that("add_blur", {
#   shift_blur <- c("Day" = "Working", "Night" = "Working")
#
#   pipe <- ShiftsWorked |>
#     add_blur(Shift, blur=shift_blur)
#
#   new.data <- ShiftsWorked |>
#     apply_deident(pipe)
#
#   expect_true(
#     any(ShiftsWorked$Shift != new.data$Shift)
#   )
#
# })
