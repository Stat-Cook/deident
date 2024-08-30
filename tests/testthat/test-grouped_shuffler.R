test_that("GroupedShuffler tests",{
  
  frm <- data.frame(A = letters, B = rnorm(26))
  
  grps <- GroupedShuffler$new(A) 
    
  expect_equal(grps$str(), "GroupedShuffler(group_on=A)")
  
  new.data <- grps$mutate(frm, B)
  expect_true(all(
    new.data$B == frm$B
  ))
    
  grps <- GroupedShuffler$new(A, limit=1) 
  new.data <- grps$mutate(frm, B)
  
  expect_true(all(
    is.na(new.data$B)
  ))

})
