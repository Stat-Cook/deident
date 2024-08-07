% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api.R
\name{add_pseudonymize}
\alias{add_pseudonymize}
\title{De-identification via  replacement}
\usage{
add_pseudonymize(object, ..., lookup = list())
}
\arguments{
\item{object}{Either a \code{data.frame}, \code{tibble}, or existing \code{DeidentList} pipeline.}

\item{...}{variables to be transformed.}

\item{lookup}{a pre-existing name-value pair to define intended psuedonymizations.
Instances of 'name' will be replaced with 'value' on transformation.#'}
}
\value{
A 'DeidentList' representing the untrained transformation pipeline.
The object contains fields:
\itemize{
\item \code{deident_methods} a list of each step in the pipeline (consisting of \code{variables} and \code{method})
}

and methods:
\itemize{
\item \code{mutate} apply the pipeline to a new data set
\item \code{to_yaml} serialize the pipeline to a '.yml' file
}
}
\description{
\code{add_pseudonymize()} adds a psuedonymization step to a transformation pipeline.
When ran as a transformation, terms that have not been seen before are given a new
random alpha-numeric string while terms that have been prefeviously transformed
reuse the same term.
}
\examples{

# Basic usage; 
pipe.pseudonymize <- add_pseudonymize(ShiftsWorked, Employee)
pipe.pseudonymize$mutate(ShiftsWorked)

pipe.pseudonymize2 <- add_pseudonymize(ShiftsWorked, Employee, 
                                    lookup=list("Kyle Wilson" = "Kyle"))
pipe.pseudonymize2$mutate(ShiftsWorked)

}
\keyword{API}
