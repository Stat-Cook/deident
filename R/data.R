#' Synthetic data set listing daily shift pattern for fictitious employees
#'
#' A synthetic data set intended to demonstrate the design and application of a
#' deidentification pipeline.  Employee names are entirely fictitious and constructed
#' from the
#' \href{https://www.kaggle.com/datasets/fivethirtyeight/fivethirtyeight-most-common-name-dataset?resource=download&select=new-top-surnames.csv}{`FiveThirtyEight Most Common Name Dataset`}.
#'
#' @format  A data frame with 3,100 rows and 6 columns:
#' \describe{
#'   \item{Record ID}{Table primary key (integer)}
#'   \item{Employee}{Name of listed employee}
#'   \item{Date}{The date being considered}
#'   \item{Shift}{The shift-type done by `employee` on `date`.  One of 'Day', 'Night' or 'Rest'.}
#'   \item{Shift Start}{Shift start time (missing if on 'Rest' shift)}
#'   \item{Shift End}{Shift end time (missing if on 'Rest' shift)}
#'   \item{Daily Pay}{Shift end time (missing if on 'Rest' shift)}
#' }
#'
"ShiftsWorked"
