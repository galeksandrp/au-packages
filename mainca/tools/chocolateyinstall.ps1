$updateData = '[
    {
        "checksumType":  "sha256",
        "url":  "https://e-trust.gosuslugi.ru/Shared/DownloadCert?thumbprint=8CAE88BBFD404A7A53630864F9033606E1DC45E2",
        "checksum":  "4e450e4971f2d77d22567b55ecc2162b3dfd0d2fa6a8da8a92cdcabc80489b59",
        "filename":  "8CAE88BBFD404A7A53630864F9033606E1DC45E2.cer"
    },
    {
        "checksumType":  "sha256",
        "url":  "https://e-trust.gosuslugi.ru/Shared/DownloadCert?thumbprint=4BC6DC14D97010C41A26E058AD851F81C842415A",
        "checksum":  "bae62b5b7bede326b06856fb67a2a471268f9f404e5b18fdf40261c3e63010b1",
        "filename":  "4BC6DC14D97010C41A26E058AD851F81C842415A.cer"
    }
]'

($updateData | ConvertFrom-Json) | % {
	$packageArgs = @{
	  packageName            = "$env:chocolateyPackageName"
	  FileFullPath           = "$env:TMP\$($_.filename)"
	  url                    = $_.url
	  checksum               = $_.checksum
	  checksumType           = $_.checksumType
	}
	Get-ChocolateyWebFile @packageArgs

	# Qualified certificate - signed by someone which certificate is signed by someone which certificate is signed by ... Russian authority at last
	# Non-qualified certifcate - signed by someone which certificate is signed by someone which certificate is signed by ... someone with self-signed certifcate

	# Russian authority qualified Root certificate
	Import-Certificate -FilePath "$env:TMP\$($_.filename)" -CertStoreLocation Cert:\LocalMachine\Root
}
