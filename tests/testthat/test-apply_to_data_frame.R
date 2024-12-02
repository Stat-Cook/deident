df <- data.frame(A = sample(letters[1:4], 100, T))

test_that(
  "apply_to_data_frame.BaseDeident methods",
  {
    enc <- Encrypter$new()

    df_BaseDeident <- apply_to_data_frame(df, enc, A)
    expect_equal(dim(df), dim(df_BaseDeident))
    expect_equal(colnames(df), colnames(df_BaseDeident))
    expect_true(all(df$A != df_BaseDeident$A))
  }
)

test_that(
  "apply_to_data_frame.character methods",
  {
    df_character <- apply_to_data_frame(df, "Encrypter", A)
    expect_equal(dim(df), dim(df_character))
    expect_equal(colnames(df), colnames(df_character))
    expect_true(all(df$A != df_character$A))
  }
)

test_that(
  "apply_to_data_frame.DeidentTask methods",
  {
    enc_task <- create_deident("Encrypter", A)

    df_DeidentTask <- apply_to_data_frame(df, enc_task)
    expect_equal(dim(df), dim(df_DeidentTask))
    expect_equal(colnames(df), colnames(df_DeidentTask))
    expect_true(all(df$A != df_DeidentTask$A))
  }
)
