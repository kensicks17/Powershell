# Import Quest Active Directory Module

Import-Module ActiveDirectory

# Add Quest ActiveRoles Snapin

Add-PSSnapin Quest.ActiveRoles.ADManagement

# Set Signing Policy

# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV E:\CreateStaffUsers\Staff.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {

# Ask For Username

$Username=Read-Host -Prompt 'Input THe Username'

# Store Group

$Group=Read-Host -Prompt 'Input The Group'

Write-Host "The Username is '$Username' and The Group is '$Group'"

icacls.exe \\fs03\HomedirsStaff_$Group$\$Username /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v2 /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v6 /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\HomedirsStaff_$Group$\$Username /setowner Administrators
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v2 /setowner Administrators
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v6 /setowner Administrators

}