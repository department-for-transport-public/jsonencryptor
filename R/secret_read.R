#' Read in password protected json file from the folder inst/secret
#'
#' @name secret_read
#' @export
#'
#' @param path File name of the encrypted json key
#'
#' @importFrom sodium data_decrypt
#' @importFrom gargle secret_nonce

secret_read <- function(path) {

  path <- file.path("inst/secret", path)

  raw <- readBin(path, "raw", file.size(path))

  decrypted <- sodium::data_decrypt(
    bin = raw,
    key = secret_pw_get("GARGLE_PASSWORD"),
    nonce = gargle:::secret_nonce()
  )

  rawToChar(decrypted)
}

json <- secret_read("gargle-test.json")
bq_auth(path = rawToChar(json))
