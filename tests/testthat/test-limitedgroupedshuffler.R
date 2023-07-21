test_that(
  "LimitedGroupShuffler - limit test",
  {
    df <- data.frame(A = letters[1:20], B = rnorm(20))

    lgs <- LimitedGroupedShuffler$new(A)
    dl <- deident(lgs, B)

    df.lgs <- dl$mutate(df)
    expect_true(all(is.na(df.lgs$B)))
  }
)

test_that(
  "LimitedGroupShuffler - non limit test",
  {
    df <- data.frame(A = letters[1:10], B = rnorm(20))

    lgs <- LimitedGroupedShuffler$new(A)
    dl <- deident(lgs, B)

    df.lgs <- dl$mutate(df)
    expect_false(any(is.na(df.lgs$B)))
  }
)
