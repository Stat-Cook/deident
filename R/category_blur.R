#' Utility for producing 'blur'
#' 
#' @param vec The vector of values to be used 
#' @param ... `Replacement` = `RegexPattern` pairs of arguments
#' 
#' @export
#' @importFrom purrr map imap
category_blur <- function(vec, ...){
  
  quo <- enquos(...)
  rules <- map(quo, rlang::quo_squash)
  
  .names <- names(rules)
  names(rules)[.names == ""] <- rules[.names == ""]
  
  .vec <- unique(vec)
  
  result <- map(
    rules,
    function(i){
      vec.match <- str_detect(.vec, i)

      match <- .vec[vec.match]
      .vec <<- .vec[!vec.match]
    
      match
        
    }
  )

  result <- result[map(result, length) > 0]
  
  result <- imap(
    result, 
    \(x, y) data.frame(
      Original = x,
      Transformed = y
    )
  )
  
  result <- do.call(rbind, result)
  
  blur.vec <- result$Transformed
  names(blur.vec) <- result$Original
  blur.vec
}


