df <- data.frame(
  A = sample(letters[1:4], 100, T),
  B = sample(letters[1:4], 100, T),
  C = sample(letters[1:4], 100, T),
  D = rnorm(100),
  E = rnorm(100,0, 4)
)

nb <- NumericBlurer$new()

test_that(
  "deident single step",
  {
    deidentlist.A <- deident(df) |>
      deident("encrypt", A)

    df.mut.A <- deidentlist.A$mutate(df)
    expect_equal(dim(df), dim(df.mut.A))

    expect_true(all(df$A != df.mut.A$A))
    expect_true(all(select(df, -A) == select(df.mut.A, -A)))

  }
)

test_that(
  "deident single step to and from file",
  {
    deidentlist.A <- deident(df) |>
      deident("encrypt", A)

    deidentlist.A$to_yaml("deidentListA.yml")
    withr::defer(fs::file_delete("deidentListA.yml"))
    .list <- yaml::read_yaml("deidentListA.yml")

    deidentlist.A.yml <- deident(df) |>
      deident(.list)

    df.mut.A <- deidentlist.A$mutate(df)
    df.mut.A.yml <- deidentlist.A.yml$mutate(df)

    expect_equal(dim(df.mut.A), dim(df.mut.A.yml))

    expect_true(all(df$A != df.mut.A.yml$A))
    expect_true(all(select(df, -A) == select(df.mut.A.yml, -A)))

    expect_true(all(df.mut.A == df.mut.A.yml))

  }
)

test_that(
  "deident multistep",
  {
    deidentlist.ADE <- deident(df) |>
      deident("encrypt", A) |>
      deident(nb, D) |>
      deident("NumericBlurer", E, cuts=c(-2,0,2))

    df.mut.ADE <- deidentlist.ADE$mutate(df)
    expect_equal(dim(df), dim(df.mut.ADE))

    expect_true(all(df$A != df.mut.ADE$A))
    expect_true(all(df$D != df.mut.ADE$D))
    expect_true(all(df$E != df.mut.ADE$E))
    expect_true(all(select(df, -c(A, D, E)) == select(df.mut.ADE, -c(A, D, E))))

  }
)

test_that(
  "deident multiple step to and from file",
  {
    deidentlist.ADE <- deident(df) |>
      deident("encrypt", A) |>
      deident(nb, D) |>
      deident("NumericBlurer", E, cuts=c(-2,0,2))

    deidentlist.ADE$to_yaml("deidentListADE.yml")
    withr::defer(fs::file_delete("deidentListADE.yml"))
    .list <- yaml::read_yaml("deidentListADE.yml")

    deidentlist.ADE.yml <- deident(df) |>
      deident(.list)

    df.mut.ADE <- deidentlist.ADE$mutate(df)
    df.mut.ADE.yml <- deidentlist.ADE$mutate(df)

    expect_equal(dim(df.mut.ADE), dim(df.mut.ADE.yml))

    expect_true(all(df$A != df.mut.ADE.yml$A))
    expect_true(all(df$D != df.mut.ADE.yml$D))
    expect_true(all(df$E != df.mut.ADE.yml$E))
    expect_true(all(select(df, -c(A, D, E)) == select(df.mut.ADE.yml, -c(A, D, E))))

    expect_true(all(df.mut.ADE == df.mut.ADE.yml))

  }
)

test_that(
  "deident different methods test",
  {

    dl.character <- deident("encrypt", A)
    dl.generator <- deident(Encrypter, A)
    enc <- Encrypter$new()
    dl.R6 <- deident(enc, A)

    df.character <- dl.character$mutate(df)
    df.generator <- dl.generator$mutate(df)
    df.R6 <- dl.R6$mutate(df)

    expect_equal(dim(df), dim(df.character))
    expect_equal(dim(df), dim(df.generator))
    expect_equal(dim(df), dim(df.R6))

    expect_true(all(df$A != df.character$A))
    expect_true(all(df$A != df.generator$A))
    expect_true(all(df$A != df.R6$A))

    expect_true(all(select(df, -A) == select(df.character, -A)))
    expect_true(all(select(df, -A) == select(df.generator, -A)))
    expect_true(all(select(df, -A) == select(df.R6, -A)))

    expect_true(all(df.character == df.generator))
    expect_true(all(df.character == df.R6))
  }
)

test_that(
  "deident different methods with init list test",
  {
    key <<- "KEY"
  
    dl.character <- deident("encrypt", A, hash_key=key)
    dl.generator <- deident(Encrypter, A, hash_key=key)
    enc <- Encrypter$new(hash_key=key)
    dl.R6 <- deident(enc, A)
  
    df.character <- dl.character$mutate(df)
    df.generator <- dl.generator$mutate(df)
    df.R6 <- dl.R6$mutate(df)

    expect_equal(dim(df), dim(df.character))
    expect_equal(dim(df), dim(df.generator))
    expect_equal(dim(df), dim(df.R6))

    expect_true(all(df$A != df.character$A))
    expect_true(all(df$A != df.generator$A))
    expect_true(all(df$A != df.R6$A))

    expect_true(all(select(df, -A) == select(df.character, -A)))
    expect_true(all(select(df, -A) == select(df.generator, -A)))
    expect_true(all(select(df, -A) == select(df.R6, -A)))

    expect_true(all(df.character == df.generator))
    expect_true(all(df.character == df.R6))

  }
)

test_that(
  "Deident from Generator",
  {
    dl <- deident(ShiftsWorked,Pseudonymizer, Employee, lookup=list(Bob="asjkdha"))
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
      list(Bob="asjkdha")
    )
  }
)

test_that(
  "Deident from object",
  {
    
    psu <- Pseudonymizer$new(lookup=list(Bob="asjkdha"))
    
    dl <- deident(ShiftsWorked,psu, Employee)
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
      list(Bob="asjkdha")
    )
  }
)


test_that(
  "Deident from character",
  {
    dl <- deident(ShiftsWorked, "Pseudonymizer", Employee, lookup=list(Bob="asjkdha"))
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
      list(Bob="asjkdha")
    )
  }
)

