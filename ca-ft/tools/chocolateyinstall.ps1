$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'http://cryptoca.ru/cdp/ca-ft.zip'
  UnzipLocation          = "$env:TMP"
  checksum               = 'ba46f4dfc36ab6e9f7878d6ba0d8c80208b39990ed61fb929a9fdc30ab3e580b'
  checksumType           = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# Qualified certificate - signed by someone which certificate is signed by someone which certificate is signed by ... Russian authority at last
# Non-qualified certifcate - signed by someone which certificate is signed by someone which certificate is signed by ... someone with self-signed certifcate

# Russian authority qualified Root certificate
Import-Certificate -FilePath "$env:TMP\Головной.cer" -CertStoreLocation Cert:\LocalMachine\Root

# Fintender Certificate Authority non-qualified Root certificate
Import-Certificate -FilePath "$env:TMP\ftcrypto44.crt" -CertStoreLocation Cert:\LocalMachine\Root

# Russian authority qualified intermediate certificate
Import-Certificate -FilePath "$env:TMP\ГУЦ.cer" -CertStoreLocation Cert:\LocalMachine\CA

# Fintender Certificate Authority non-qualified intermediate certificate
Import-Certificate -FilePath "$env:TMP\ftcrypto2.crt" -CertStoreLocation Cert:\LocalMachine\CA
