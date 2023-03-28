#' Create a very secure random password
#'
#' @name secret_pw_gen
#' @export
#'

secret_pw_gen <- function() {
  x <- sample(c(letters, LETTERS, 0:9), 50, replace = TRUE)
  paste0(x, collapse = "")
}
