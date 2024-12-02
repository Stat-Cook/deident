## code to prepare starwars dataset goes here

library(dplyr)

print("Importing starwars Data")

usethis::use_data(starwars, overwrite = TRUE)
