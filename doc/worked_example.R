## ---- include = FALSE---------------------------------------------------------
library(lemon)

library(knitr)
hook_output <- knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
  lines <- options$output.lines
  if (is.null(lines)) {
    return(hook_output(x, options))  # pass to default hook
  }
  x <- unlist(strsplit(x, "\n"))
  more <- "..."
  if (length(lines)==1) {        # first n lines
    if (length(x) > lines) {
      # truncate the output, but add ....
      x <- c(head(x, lines), more)
    }
  } else {
    x <- c(more, x[lines], more)
  }
  # paste these lines together
  x <- paste(c(x, ""), collapse = "\n")
  hook_output(x, options)
})

local_print <- function(x, options, ...){
  x <- head(x)
  lemon_print(x, options, ...)
}

knit_print.data.frame <- local_print

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(deident)

## ---- render=local_print------------------------------------------------------
library(deident)
ShiftsWorked

## ---- render=local_print------------------------------------------------------
pipeline <- deident(ShiftsWorked, "psudonymize", Employee)
deident:::apply_deident(ShiftsWorked, pipeline)

## ---- render=local_print------------------------------------------------------
psu <- Pseudonymizer$new()
pipeline2 <- deident(ShiftsWorked, psu, Employee)

deident:::apply_deident(ShiftsWorked, pipeline2)

## ---- output.lines=4----------------------------------------------------------
unlist(psu$lookup)

## ---- render=local_print------------------------------------------------------
blur <- NumericBlurer$new(cuts = c(0, 100, 200, 300))

multistep_pipeline <- ShiftsWorked |> 
  deident(psu, Employee) |> 
  deident(blur, `Daily Pay`)

ShiftsWorked |> 
  deident:::apply_deident(multistep_pipeline)

## ---- render=local_print------------------------------------------------------
multistep_pipeline$to_yaml("multistep_pipeline.yml")

restored_pipeline <- deident:::from_yaml("multistep_pipeline.yml")

ShiftsWorked |> 
  deident:::apply_deident(restored_pipeline)

