The jsonencryptor package is designed to encrypt JSON service account keys using the secure sodium encryption package. This makes them secure to use both locally and as part of the rsconnect Shiny hosting platform.

## Installation

To install this package directly from github run:

`remotes::install_github("department-for-transport-public/jsonencryptor")`

## Generating a secure password

You can either create your own password or get the package to generate it for you, using the `secret_pw_gen()` function.

To use the password during development in Cloud R and to use it to encrypt a json file, assign it to a local variable with `Sys.setenv("GARGLE_PASSWORD" = your_password)`. To use it in rsconnect, navigate to a dashboard you have publisher permissions for, and select the _vars_ tab. Create a new variable with the _name_ GARGLE_PASSWORD and a _value_ of your password, making sure you don't use quotation marks for either. 

![image](https://user-images.githubusercontent.com/84339173/228290578-c89e3d95-25e3-458a-a157-f1f2234991a6.png)

## Encrypting a json key with your password

Once you have generated your password and saved it as a local variable, you can encrypt a saved json service key token.

Use the `secret_write()` function to do this, passing it three arguments:

* The _name_ of the encrypted output file. This function will always save it in a folder called inst/secret.
* The filepath of the _input_ unencrypted json file. 
* (Optional) the _dir_ (directory) you want to write out to. By default this will be your working directory, but you can change this particularly for working with shiny apps (which have a working directory inside their folder structure).

This service key token is fully encrypted and you are fine to treat it like any other text object (e.g. you can upload this to Github and publish to rsconnect).

## Unencrypting your json key to use it

To unencrypt your json key, use the `secret_read()` function, passing it the file name of your encrypted json key inside the inst/secret folder. This function can be used directly inside the gargle function to authenticate access to big query e.g.:

`bq_auth(path = secret_read("my_access_token.json"))`

or in the similar googleCloudStorageR function to authenticate access to GCS:

`gcs_auth(secret_read("my_access_token.json"))`

Both locally and on rsconnect you will need to have set your password variable before this will work.



