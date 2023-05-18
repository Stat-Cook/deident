# set.seed(101)
#
# n <- 1000
#
# frm <- data.frame(
#   A = sample(letters[1:2], n, T),
#   B = sample(letters[1:2], n, T),
#   C = rnorm(n),
#   D = rnorm(n, 0 ,5),
#   E = letters[1:4],
#   F = rnorm(n),
#   G = letters[1:4]
# ) %>% mutate(E = sort(E), G = sort(G))
# frm
#
# enc <- create_deident(
#   "Encrypter", A,
#   init.list=list(hash_key="qwerty_key", seed="qwerty_seed")
# )
#
# expect_equal(enc$method$seed, "qwerty_seed")
# expect_equal(enc$method$hash_key, "qwerty_key")
#
# dlist <- DeidentList$new(frm)
# dlist$add_method(Encrypter, A, B)
# dlist$add_method(Pseudonymizer, B)
# dlist$add_method(NumericBlurer, C, init.list = list(cuts = c(0, 5)))
# dlist$add_method(Perturber, D, init.list = list(sd = 3))
# dlist$add_method(Shuffler, E)
# dlist$add_method(GroupedShuffler, F, init.list = list(as.symbol("G")))
# dlist
#
#
#
#
# gs <- GroupedShuffler$new(... = )
#
# dlist$mutate(frm) %>% group_by(G) %>% dplyr::summarize(mean(F))
#
# frm %>% group_by(G) %>% dplyr::summarize(mean(F))
#
# "Encrypter" = Encrypter,
# "Perturber" = Perturber,
# "Blurer" = Blurer,
# "NumericBlurer" = NumericBlurer,
# "GroupedShuffler" = GroupedShuffler,
#
# dlist$mutate(frm)
#
# serialize(dlist)
#
# yml <- serialize(dlist)
# yml[[1]]
# dlist2 <- DeidentList$new(frm)
#
# for (y in yml){
#   dlist2$add_method(
#     y$Type,
#     !!!labels_as_symbols(y$Variables),
#     init.list = init.list.f(on_init = y$OnInit, dot.args = y$Dots)
#   )
# }
#
# dlist2$mutate(frm)
#
#
# any(enc.A$A != frm$A)
# all(enc.A$B == frm$B)
# all(enc.A$C == frm$C)
#
# init.list.f <- function(on_init=list(), dot.args=c()){
#   .dots <- labels_as_symbols(dot.args)
#   append(on_init, .dots)
# }
#
# dlist <- DeidentList$new(frm)
# init.list <- init.list.f(on_init=list(hash_key="qwerty_key", seed="qwerty_seed"))
# dlist$add_method("Encrypter", A,
#                  init.list=init.list)
# dlist$mutate(frm)
#
# init.list <- init.list.f(on_init=list(), dot.args=c("A", "B"))
# dlist$add_method("GroupedShuffler", C, init.list=init.list)
#
#
# as.list(dlist)
#
# dlist$mutate(frm) |> group_by(A, B) |> dplyr::summarise(mean(C))
# frm |> group_by(A, B) |> dplyr::summarise(mean(C))
#
#
#
# frm |> group_by(A, B) |> dplyr::summarise(median(C))
# enc.A <- dlist$mutate(frm)
#
# any(enc.A$A != frm$A)
# all(enc.A$B == frm$B)
# all(enc.A$C == frm$C)
#
