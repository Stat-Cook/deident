test_that("cateogry blur basics", {
  .vec <- starwars$species

  species_blur <- category_blur(.vec, NonHuman = "^(?!Human)")

  expect_false(
    "Human" %in% names(species_blur)
  )

  expect_equal(
    length(species_blur) + 1,
    length(unique(.vec))
  )
})
