---
title: 'Deident: An R package for data anonymization'
tags:
  - R
authors:
  - name: Robert M. Cook
    orcid: 0000-0003-3343-8271
    equal-contrib: false
    affiliation: 1
  - name: Md Asaduzaman
    orcid: 0000-0002-8885-6721
    equal-contrib: false # (This is how you can denote equal contributions between multiple authors)
    affiliation: 1
  - name: Sarahjane Jones
    orcid: 0000-0003-4729-4029
    equal-contrib: false # (This is how you can denote equal contributions between multiple authors)
    affiliation: 1
affiliations:
 - name: Staffordshire University, England
   index: 1
date: 12 December 2023

---
# Summary

Research in the discipline of health data is of increasing interest due
to the perception that artificial intelligence (AI) and machine learning
(ML) techniques have the promise to bridge gaps in the large,
resource-limited sector (Harwich and Laycock 2018; Wilson 2019; Nelson
et al. 2019; Yu, Beam, and Kohane 2018). One key aspect of working
within health data is the necessity to work within the ethical and legal
frameworks of research with human participants(Sales and Folkman 2000;
UKRI 2022), notably around the risks posed by the processing of
personally identifiable data (PID) and pseudo-PID (variables which if
used together can identify an individual)(ICO 2023).

One approach to dealing with PID concerns is to apply transformations to
the data, e.g. encryption of names, or aggregation of ages, which can
limit the risk of identification at the cost of nuance(Tachepun and
Thammaboosadee 2020). Hence, we demonstrate an extendable package of
tools for the implementation and application of deidentification
techniques to panel datasets.

# Statement of need

In order to broaden the access to sensitive data, data handlers need an
auditable open process for the application of data transforms that limit
the risk of personal identification (sometimes refereed to as ‘data
masking’ transformations). Several production scale systems exist for
applying data masking transformations
(e.g. [Delphix](https://www.delphix.com/),
[K2View](https://www.k2view.com), and
[Accutive](https://accutive.com/)), but these are often expensive and
cumbersome, limiting uptake in the domain of research. The research
community hence requires a simple toolbox for the application of several
common ‘data masking transforms’ implemented in an open source language.

This implementation of the “deident” methods is in R, chosen due to the
increase adoption of open source software into the working practices of
the NHS (driven by the growth on the NHS-R community and similar
groups). However, the underlying specification, and implementation of
the transforms can be ported to other languages.

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

Following the design principles of the existing tidyverse domain for
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

# In practice

To install the current version of the `deident` package, run the command

``` r
devtools::install_github("Stat-Cook/deident")
```

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

An in depth example can be found in the `Worked Example` vigentte, while
more details on each method are presented in the `deident transforms`
vignette.

## Current applications

The `deident` toolbox was developed for applications in the NuRS and
AmreS research projects which aim to extract and analyze retrospective
operational data from NHS Trusts to understand staff retention and
patient safety.

## Acknowledgements

The development of `deident` was part of the he NuRS and AmreS projects
funded by the Health Foundation.

Harwich, Eleonora, and Kate Laycock. 2018. “Thinking on Its Own: AI in
the NHS.” *Reform Research Trust*.

ICO. 2023. “What Is Personal Information: A Guide.” 2023.
<https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/personal-information-what-is-it/what-is-personal-information-a-guide/>.

Nelson, Amy, Daniel Herron, Geraint Rees, and Parashkev Nachev. 2019.
“Predicting Scheduled Hospital Attendance with Artificial Intelligence.”
*NPJ Digital Medicine* 2 (1): 26.

Sales, Bruce D, and Susan Ed Folkman. 2000. *Ethics in Research with
Human Participants.* American Psychological Association.

Tachepun, Chitanut, and Sotarat Thammaboosadee. 2020. “A Data Masking
Guideline for Optimizing Insights and Privacy Under GDPR Compliance.” In
*Proceedings of the 11th International Conference on Advances in
Information Technology*, 1–9.

UKRI. 2022. “Framework for Research Ethics.” 2022.
<https://www.ukri.org/councils/esrc/guidance-for-applicants/research-ethics-guidance/framework-for-research-ethics>.

Wilson, Clare. 2019. “High-Tech Plans for the NHS.” Elsevier.

Yu, Kun-Hsing, Andrew L Beam, and Isaac S Kohane. 2018. “Artificial
Intelligence in Healthcare.” *Nature Biomedical Engineering* 2 (10):
719–31.
