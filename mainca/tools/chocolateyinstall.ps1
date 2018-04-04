$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileFullPath           = "$env:TMP\8CAE88BBFD404A7A53630864F9033606E1DC45E2.cer"
  url                    = 'https://e-trust.gosuslugi.ru/Shared/DownloadCert?thumbprint=8CAE88BBFD404A7A53630864F9033606E1DC45E2'
  checksum               = '4e450e4971f2d77d22567b55ecc2162b3dfd0d2fa6a8da8a92cdcabc80489b59'
  checksumType           = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

# Qualified certificate - signed by someone which certificate is signed by someone which certificate is signed by ... Russian authority at last
# Non-qualified certifcate - signed by someone which certificate is signed by someone which certificate is signed by ... someone with self-signed certifcate

# Russian authority qualified Root certificate
Import-Certificate -FilePath "$env:TMP\8CAE88BBFD404A7A53630864F9033606E1DC45E2.cer" -CertStoreLocation Cert:\LocalMachine\Root
