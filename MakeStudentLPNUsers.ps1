# Import Quest Active Directory Module

Import-Module ActiveDirectory

# Add Quest ActiveRoles Snapin

Add-PSSnapin Quest.ActiveRoles.ADManagement

# Set Signing Policy

# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV E:\CreateStaffUsers\LPN.csv

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

# Create User in Active Directory

NEW-QADUSER –FirstName $Person.Firstname –Lastname $Person.Lastname –Name $Name –SamAccountName $Username –UserPassword $Password –UserPrincipalName $UPN –ParentContainer ‘pcti.tec.nj.us/Students/LPN’ -DisplayName $Name -Mail $Username"@pcti.mobi"

# Pause 30 Seconds For Account Creation

Start-Sleep -s 30

# Set Change Password At Login

Set-ADUser $Username -changepasswordatlogon $true
# Set Description

Set-ADUser $Username -Description $Person.Description

Add-ADGroupMember -Identity $Person.StaffGroup -Members $Username
Add-ADGroupMember -Identity "Wireless LAN Students" -Members $Username

}