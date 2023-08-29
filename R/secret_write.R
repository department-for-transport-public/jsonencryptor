#' Write out password protected json file to the folder inst/secret
#'
#' @name secret_write
#' @export
#'
#' @param path File name of the encrypted json key
#' @param input File name of the original unencrypted json key
#' @param dir Location to save the inst/secret folder to. Defaults to the current working directory
#'
#' @importFrom sodium data_encrypt hex2bin
#' @importFrom fs path dir_create
#'
secret_write <- function(name, input, dir = getwd()) {

  if(!file.exists(input)){

    stop("Json key not found at location ", input)

  }

   if (is.character(input)) {
    input <- readBin(input, "raw", file.size(input))
  } else if (!is.raw(input)) {
    stop("Input needs to be a character or raw file")
  }


  ##Create directory location
  destdir <- fs::path(dir, "inst", "secret")
  fs::dir_create(destdir)
  destpath <- fs::path(destdir, name)

  if(Sys.getenv("GARGLE_PASSWORD") == ""){

    stop("Gargle password not provided as environmental variable. Use Sys.setenv('GARGLE_PASSWORD' = your_password) to set this")

  }

  enc <- sodium::data_encrypt(
    msg = input,
    key = secret_pw_get("GARGLE_PASSWORD"),
    nonce =  sodium::hex2bin("cb36bab652dec6ae9b1827c684a7b6d21d2ea31cd9f766ac")
  )
  attr(enc, "nonce") <- NULL
  writeBin(enc, destpath)

  message("Encrypted key written to ", destpath)

  invisible(destpath)
}
