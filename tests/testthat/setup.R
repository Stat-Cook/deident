library(dplyr)
library(checkmate)

withr::defer(
  {
    # write.table(ShiftsWorked, file = "tests/testthat/test_data/ShiftsWorked.tsv", row.names=FALSE, sep="\t")
    # write.csv(ShiftsWorked, "tests/testthat/test_data/ShiftsWorked.csv")
    # openxlsx::write.xlsx(ShiftsWorked, "tests/testthat/test_data/ShiftsWorked.xlsx")
  },
  teardown_env()
)

readr::write_excel_csv
