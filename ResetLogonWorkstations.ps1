# Import Quest Active Directory Module

Import-Module ActiveDirectory

# Add Quest ActiveRoles Snapin

Add-PSSnapin Quest.ActiveRoles.ADManagement

# Set Signing Policy

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV D:\CreateStaffUsers\SBUsers.csv

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

# Set Logon Workstations To All

Set-ADUser $Username -LogOnWorkstations $null

}