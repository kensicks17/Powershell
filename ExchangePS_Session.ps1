$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://ex-mb-02.pcti.tec.nj.us/PowerShell/ -Authentication Kerberos -Credential $UserCredential -AllowRedirection
Import-PSSession $Session -DisableNameChecking