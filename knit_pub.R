rmarkdown::render("paper.Rmd")

#knitr::knit("paper.Rmd")

preamble <- readr::read_lines("preamble.txt")

c(preamble, readr::read_lines("paper.md")) |>
  stringr::str_replace_all("\\\\\\[", "\\[") |>
  stringr::str_replace_all("\\\\\\]", "\\]") |>
  readr::write_lines("paper.md")
