get_types <- function(dlist){
  dlist$deident_methods |>
    purrr::map("method") |>
    purrr::map(~ .$str()) |>
    unlist()
}

get_variables <- function(dlist){
  dlist$deident_methods |>
    purrr::map("variables")
}

get_from_method <- function(dlist, item){
  dlist$deident_methods |>
    purrr::map("method") |>
    purrr::map(item) |>
    unlist()
}

test_that(
	"from-yaml test",
	{
	  enc <- Encrypter$new(hash_key = "qwerty", seed=101)

	  dl <- deident(enc, A) |>
	    deident(NumericBlurer, C)

    yaml::write_yaml(serialize(dl), "temp.yml")

    # dl.yml <- yaml::read_yaml("temp.yml") |>
    #   deident()
    
    dl.yml <- from_yaml("temp.yml")

    expect_equal(get_types(dl.yml), get_types(dl))
    expect_equal(get_variables(dl.yml), get_variables(dl))
    expect_equal(
      get_from_method(dl, "hash_key"),
      get_from_method(dl.yml, "hash_key")
    )
    expect_equal(
      get_from_method(dl, "seed"),
      get_from_method(dl.yml, "seed")
    )
    
    from_yaml("temp.yml")
	}
)

