#' Read in password protected json file from the folder inst/secret
#'
#' @name secret_read
#' @export
#'
#' @param path File name of the encrypted json key
#'
#' @importFrom sodium data_decrypt hex2bin

secret_read <- function(path) {

  path <- file.path("inst/secret", path)

  if(!file.exists(path)){

    stop("Encrypted json key not found at location: ", path)

  }

  if(Sys.getenv("GARGLE_PASSWORD") == ""){

    stop("Gargle password not provided as environmental variable. Use Sys.setenv('GARGLE_PASSWORD' = your_password) to set this")

  }

  raw <- readBin(path, "raw", file.size(path))

  decrypted <- sodium::data_decrypt(
    bin = raw,
    key = secret_pw_get("GARGLE_PASSWORD"),
    nonce =  sodium::hex2bin("cb36bab652dec6ae9b1827c684a7b6d21d2ea31cd9f766ac")
  )

  rawToChar(decrypted)
}
