#' Extract password in raw format from an environment object
#'
#' @name secret_pw_get
#'
#' @param env_name Name of the password variable in either your local environment or rsconnect. Passed as a string.
#'
#' @importFrom sodium sha256

secret_pw_get <- function(env_name) {

  pw <- Sys.getenv(env_name)
  sodium::sha256(charToRaw(pw))
}


