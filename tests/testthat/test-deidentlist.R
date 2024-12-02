
test_that(
  "Add step with Generator",
  {
    dl <- DeidentList$new()
    dl$add_method(Pseudonymizer, Employee, lookup = list("Bob" = "asjkdha"))

    d <- dl$deident_methods[[1]]
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
  }
)

test_that(
  "Add step with object",
  {
    dl <- DeidentList$new()
    psu <- Pseudonymizer$new(lookup = list("Bob" = "asjkdha"))
    dl$add_method(psu, Employee)

    d <- dl$deident_methods[[1]]
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
  }
)

test_that(
  "Add step with character",
  {
    dl <- DeidentList$new()
    dl$add_method("Pseudonymizer", Employee, lookup = list("Bob" = "asjkdha"))

    d <- dl$deident_methods[[1]]
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
  }
)

test_that("DeidentList print", {
  dlist <- DeidentList$new(ShiftsWorked)
  dlist.post.print <- print(dlist)

  expect_equal(
    dlist,
    dlist.post.print
  )

  dlist.nodata <- DeidentList$new()
  dlist.nodata.post.print <- print(dlist.nodata)

  expect_equal(
    dlist.nodata,
    dlist.nodata.post.print
  )
})


test_that("function binding", {
  dlist <- new_deident_list(ShiftsWorked)

  expect_equal(
    dlist$allowed_values,
    colnames(ShiftsWorked)
  )
})
