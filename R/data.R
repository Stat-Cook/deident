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

#' Starwars characters
#'
#' The original data, from SWAPI, the Star Wars API, <https://swapi.py4e.com/>, has been revised
#' to reflect additional research into gender and sex determinations of characters.  NB: taken from `dplyr`
#'
#' @format A tibble with 87 rows and 14 variables:
#' \describe{
#' \item{name}{Name of the character}
#' \item{height}{Height (cm)}
#' \item{mass}{Weight (kg)}
#' \item{hair_color,skin_color,eye_color}{Hair, skin, and eye colors}
#' \item{birth_year}{Year born (BBY = Before Battle of Yavin)}
#' \item{sex}{The biological sex of the character, namely male, female, hermaphroditic, or none (as in the case for Droids).}
#' \item{gender}{The gender role or gender identity of the character as determined by their personality or the way they were programmed (as in the case for Droids).}
#' \item{homeworld}{Name of homeworld}
#' \item{species}{Name of species}
#' \item{films}{List of films the character appeared in}
#' \item{vehicles}{List of vehicles the character has piloted}
#' \item{starships}{List of starships the character has piloted}
#' }
#' @examples
#' starwars
"starwars"