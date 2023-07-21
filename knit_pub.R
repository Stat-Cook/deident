rmarkdown::render("paper.Rmd")

preamble <- readr::read_lines("preamble.txt")

c(preamble, readr::read_lines("paper.md")) |>
  readr::write_lines("paper.md")
