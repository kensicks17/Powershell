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

# Build Username from ID

$Username=$Person.ID

# Put our Domain name into a Placeholder, who wants all that typing?

$Domain=’@pcti.tec.nj.us’

# Build the User Principal Name Username with Domain added to it

$UPN=$Username+$Domain

# Create the Displayname

$Name=$Person.Firstname+” “+$Person.Lastname+""

# Store Password From CSV File

$Password=$Person.Password

# Store Staff Group

$StaffGroup = $Person.StaffGroup

# Store Group

$Group=$Person.Group

icacls.exe \\fs03\HomedirsStaff_$Group$\$Username /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v2 /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v6 /grant PCTI\$Username":(OI)(CI)M"
icacls.exe \\fs03\HomedirsStaff_$Group$\$Username /setowner Administrators
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v2 /setowner Administrators
icacls.exe \\fs03\ProfiledirsStaff$\$Username.v6 /setowner Administrators

}