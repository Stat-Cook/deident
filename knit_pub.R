rmarkdown::render("paper.Rmd")

preamble <- "---
title: 'D-identifyR – open source tools for a data de-identification pipeline'
tags:
  - R
  - de-identification
  - data manipulation
  - PID
  - personally identifiable data
authors:
  - name: Robert M. Cook
    orcid: 0000-0000-0000-0000
    equal-contrib: true
    affiliation: 1
affiliations:
  - name: Staffordshire University, Stafford, UK
    index: 1
date: 13 August 2017
bibliography: paper.bib
---"

c(preamble, readr::read_lines("paper.md")) |>
  readr::write_lines("paper.md")
