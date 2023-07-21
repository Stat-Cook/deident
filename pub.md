---
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
---
Research in the discipline of health data is of increasing interest due
to the perception that artificial intelligence (AI) and machine learning
(ML) techniques have the promise to bridge gaps in the large,
resource-limited sector. One key aspect of working within health data is
the necessity to work within the ethical and legal frameworks of
research with human participants, notably around the risks posed by the
processing of personally identifiable data (PID) and pseudo-PID. In the
UK, there has been a drive to increase adoption of open source software
into the working practices of the NHS, corresponding to the growth on
the NHS-R community and similar groups.  
Here we demonstrate an extendable package of tools for the
implementation and application of deidentification techniques to panel
datasets.

This package implements methods for de-identification via:

-   pseudonymization – the consistent replacement of a string by a
    random string
-   encryption
-   shuffling – replacement of columns by a random sample without
    replacement
-   bluring – the aggregation of numeric or categorical data according
    to specified rules
-   perturbation – the addition of user-defined random noise to a
    numeric variable

following the design principles of the existing tidyverse domain for
ease of adoption. The package includes tools to create a single pipeline
for the application of a multi-step deidentification pipeline to
multiple files stored within the same repository, alongside the option
to serialize/ define the pipeline to/ via yaml. This approach allows a
researcher to design and implement an appropriate de-identification plan
and deliver it to the research support/ business intelligence team of an
organisation with limited knowledge of the sensitive data. The supply of
an easy method for de-identifying data sets which require little
scripting knowledge by Trust staff may aid in overcoming several
information governance risks that keep operational data siloed within
health Trusts.

The core functionality of the package is the `deident` function. To
demonstrate functionality we use a subset of the `babynames` data set
consisting of the final two years.

``` r
library(deident)

babynames <- babynames::babynames |> 
  dplyr::filter(year > 2015) |> 
  data.frame()

str(babynames)
```

    ## 'data.frame':    65448 obs. of  5 variables:
    ##  $ year: num  2016 2016 2016 2016 2016 ...
    ##  $ sex : chr  "F" "F" "F" "F" ...
    ##  $ name: chr  "Emma" "Olivia" "Ava" "Sophia" ...
    ##  $ n   : int  19471 19327 16283 16112 14772 14415 13080 11747 10957 10773 ...
    ##  $ prop: num  0.0101 0.01002 0.00844 0.00835 0.00766 ...

The `deident` function produces a pipeline of actions and the variables
to be transformed, with each subsequent call of `deident` adding a
further transformation. The first argument of `deident` can either be a
data frame or the output of a previous `deident` call.

The simplest use case is transforming one variable via a single method:

``` r
pipeline <- deident(babynames, "psudonymize", name)

apply_deident.data.frame(babynames, pipeline)
```

The same method can be applied to multiple variables by adding the
variable names:

``` r
pipeline2 <- deident(babynames, "psudonymize", name, sex)

apply_deident.data.frame(babynames, pipeline2)
```

The transformations can also be initialized as base classes, allowing
for them to be shared between pipelines:

``` r
psu <- Pseudonymizer$new()

pipeline3 <- deident(psu, Var1, Var2)
pipeline4 <- deident(psu, Var3, Var4)
```

Performing a multi-stage transformation can be done by chaining together
calls to `deident`

``` r
blur <- NumericBlurer$new(cuts=c(0, 10, 100, 1000, 10000))

pipeline3 <- deident(babynames, "psudonymize", name, sex) |>
  deident(blur, n)

apply_deident.data.frame(babynames, pipeline3)
```

For more details on each method refer to the `deident transforms`
vignette.