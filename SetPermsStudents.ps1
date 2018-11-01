# Import Quest Active Directory Module

Import-Module ActiveDirectory

# Add Quest ActiveRoles Snapin

Add-PSSnapin Quest.ActiveRoles.ADManagement

# Set Signing Policy

# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV D:\CreateStaffUsers\Students2022.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {

# Build Username from ID

$Username=$Person.ID

# Store Group

$Group=$Person.Group

icacls.exe \\fs03\Homedirs$Group$\$Username /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\Profiledirs$Group$\$Username.v2 /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\Profiledirs$Group$\$Username.v6 /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\Homedirs$Group$\$Username /setowner Administrators
icacls.exe \\fs03\Profiledirs$Group$\$Username.v2 /setowner Administrators
icacls.exe \\fs03\Profiledirs$Group$\$Username.v6 /setowner Administrators

}