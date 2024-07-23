# set.seed(101)
# 
# {
#   df <- expand.grid(
#     A = letters[1:4],
#     B = 1:5
#   ) |>
#   data.frame()
# 
#   k <- 20
# 
#   df <- mutate(df,
#                C = rnorm(20, 0, 3),
#                D = C + rnorm(20, 0, 1))
# }
# 
# grouped_mean <- function(data, grp, target){
#   result <- group_by(data, {{grp}}) |>
#     summarize(`mean` = mean({{target}}))
# 
#   result$mean
# }
# 
# test_that(
#   "GroupedShuffler - behaviour test",
#   {
#     gs <- GroupedShuffler$new(A)
#     dl <- deident(gs, C, D)
# 
#     df.shuf <- dl$mutate(df)
# 
#     expect_equal(grouped_mean(df, A, C),
#                  grouped_mean(df.shuf, A, C))
# 
#     expect_true(cor(df.shuf$C, df$C) != 1)
#     expect_true(cor(df.shuf$D, df$D) != 1)
#   }
# )
# 
# get_from_method <- function(object, item, index=1){
#   object$deident_methods[[index]]$method[[item]]
# }

# test_that(
#   "GroupedShuffler - serialize",
#   {
#     df <- data.frame(
#       A = sample(letters[1:4], 200, T),
#       B = sample(letters[1:4], 200, T),
#       C = rnorm(200, 0, 3)
#     ) |> mutate(D = C + rnorm(200))
# 
#     gs <- GroupedShuffler$new(A, B)
# 
#     dl <- df |>
#       deident(gs, C)
#     .list <- serialize(dl)
# 
#     dl.list <- deident(.list)
# 
#     # TODO:  add test that grouping vars are preserved.
# 
#     expect_equal(
#       get_from_method(dl, "limit"),
#       get_from_method(dl.list, "limit")
#     )
#   }
# )
