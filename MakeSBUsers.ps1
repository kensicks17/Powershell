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

# Create User in Active Directory

NEW-QADUSER –FirstName $Person.Firstname –Lastname $Person.Lastname –Name $Name –SamAccountName $Username –UserPassword $Password –UserPrincipalName $UPN –ParentContainer ‘pcti.tec.nj.us/Smart Board Users’ -DisplayName $Name

# Pause 30 Seconds For Account Creation

Start-Sleep -s 30

# Set Change Password At Login

Set-ADUser $Username -changepasswordatlogon $false

# Set Description

Set-ADUser $Username -Description $Person.Description

# Set Logon Computers None

Set-ADUser $Username -LogonWorkstations 'None'

# Add User To Groups

Add-ADGroupMember -Identity "Smart Boards" -Members $Username

}