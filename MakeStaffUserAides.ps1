# Import Quest Active Directory Module

Import-Module ActiveDirectory

# Add Quest ActiveRoles Snapin

Add-PSSnapin Quest.ActiveRoles.ADManagement

# Set Signing Policy

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV E:\CreateStaffUsers\NewStaff2018_Aides.csv

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

NEW-QADUSER –FirstName $Person.Firstname –Lastname $Person.Lastname –Name $Name –SamAccountName $Username –UserPassword $Password –UserPrincipalName $UPN –ParentContainer ‘pcti.tec.nj.us/Staff/Instructional Aides’ -DisplayName $Name -Mail $Username"@pcti.pcti.tec.nj.us"

# Pause 30 Seconds For Account Creation

Start-Sleep -s 30

# Set Change Password At Login

Set-ADUser $Username -changepasswordatlogon $true

# Set Description

Set-ADUser $Username -Description $Person.Description

# Set User Profile Path

Set-ADUser $Username -ProfilePath \\pcti.tec.nj.us\dfs\pdirs\Staff\$Username

# Set User Home Path

Set-ADUser $Username -HomeDirectory \\pcti.tec.nj.us\dfs\hdirs\$StaffGroup\$Username\home -HomeDrive U:

# Set Google Sync Attribute

Set-ADUser $Username -add @{extensionAttribute1="GAFE"}

# Set Employee Number Attribute

Set-ADUser $Username -add @{employeeNumber=$Person.IDNumber}

# Set Manager Attribute

Set-ADUser $username -Manager $Person.Manager

# Add User To Groups

Add-ADGroupMember -Identity Staff -Members $Username
Add-ADGroupMember -Identity $Person.StaffGroup -Members $Username
Add-ADGroupMember -Identity "PCTI Aides And Support Staff" -Members $Username
Add-ADGroupMember -Identity "Wireless LAN Staff" -Members $Username

# Enable O365 Mailbox And Archive For User

Enable-RemoteMailbox "$Username" –remoteroutingaddress $Username@passaictech.mail.onmicrosoft.com
Enable-RemoteMailbox "$Username" -Archive
}