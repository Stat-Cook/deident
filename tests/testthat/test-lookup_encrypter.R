test_that("lookup encrypter", {
  enc <- LookupEncrypter$new(hash_key = "hash", seed="seed")

  enc$transform(starwars$name)
  
  expect_true(
    length(enc$lookup) > 0
  )
})
