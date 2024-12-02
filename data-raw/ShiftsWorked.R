## code to prepare `ShiftsWorked` dataset goes here

library(lubridate)
library(dplyr)

print("Remaking ShiftsWorked Data")

{
  set.seed(101)

  firstnames <- readr::read_csv("data-raw/new-top-firstNames.csv", col_types = "icd")
  firstnames <- stringr::str_to_sentence(firstnames$name)
  surnames <- readr::read_csv("data-raw/new-top-surnames.csv", col_types = "icd")
  surnames <- stringr::str_to_sentence(surnames$name)

  individuals <- paste(sample(firstnames, 100, T), sample(surnames, 100, T))

  pay_rate <- sample(c(rpois(25, 1000), rpois(40, 2000), rpois(25, 3000), rpois(10, 4000)))
  names(pay_rate) <- individuals

  days <- seq(as.Date("2015-01-01"), as.Date("2015-01-31"), by = "d")
  frm <- expand.grid(
    `Employee` = individuals,
    `Date` = days
  )
  n <- nrow(frm)
  frm$`Record ID` <- seq(n)
  frm$Shift <- sample(c("Day", "Night", "Day", "Night", "Rest"), n, T)

  noise <- minutes(floor(rnorm(n, 0, 30)))
  start.times <- c(
    Day = as.POSIXct("2000-01-01 09:00:00", roll = T),
    Night = as.POSIXct("2000-01-01 17:00:00", roll = T),
    Rest = as.POSIXct("2000-01-01 00:00:00", roll = T)
  )

  ShiftsWorked <- frm %>%
    mutate(
      Employee = as.character(Employee),
      `Shift Start` = start.times[Shift] + noise,
      `Shift Length` = minutes(floor(rnorm(n, 7.5 * 60, 30))),
      `Shift End` = `Shift Start` + `Shift Length`,
      `Shift Start` = format(`Shift Start`, format = "%H:%m"),
      `Shift End` = format(`Shift End`, format = "%H:%m"),
      `Hours Done` = as.numeric(`Shift Length`) / 3600,
      `Hourly Rate` = pay_rate[Employee],
      `Daily Pay` = ceiling(`Hours Done` * `Hourly Rate`) / 100
    ) %>%
    select(`Record ID`, `Employee`, `Date`, `Shift`, `Shift Start`, `Shift End`, `Daily Pay`)

  ShiftsWorked[ShiftsWorked$Shift == "Rest", ]$`Shift Start` <- NA
  ShiftsWorked[ShiftsWorked$Shift == "Rest", ]$`Shift End` <- NA
  ShiftsWorked[ShiftsWorked$Shift == "Rest", ]$`Daily Pay` <- 0

  ShiftsWorked <- tibble(ShiftsWorked)
}

usethis::use_data(ShiftsWorked, overwrite = TRUE)
