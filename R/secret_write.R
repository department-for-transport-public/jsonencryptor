#' Write out password protected json file to the folder inst/secret
#'
#' @name secret_write
#' @export
#'
#' @param path File name of the encrypted json key
#' @param input File name of the original unencrypted json key
#' @param dir Location to save the inst/secret folder to. Defaults to the current working directory
#'
#' @importFrom sodium data_encrypt secret_nonce
#' @importFrom gargle gargle_abort_bad_class
#' @importFrom fs path dir_create
#'
secret_write <- function(name, input, dir = getwd()) {
  if (is.character(input)) {
    input <- readBin(input, "raw", file.size(input))
  } else if (!is.raw(input)) {
    gargle:::gargle_abort_bad_class(input, c("character", "raw"))
  }

  ##Create directory location
  destdir <- fs::path(dir, "inst", "secret")
  fs::dir_create(destdir)
  destpath <- fs::path(destdir, name)

  enc <- sodium::data_encrypt(
    msg = input,
    key = secret_pw_get("GARGLE_PASSWORD"),
    nonce = gargle:::secret_nonce()
  )
  attr(enc, "nonce") <- NULL
  writeBin(enc, destpath)

  invisible(destpath)
}
