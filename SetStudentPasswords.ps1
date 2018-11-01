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

# Store Password From CSV File

$Password=$Person.Password

# Store Staff Group

$StaffGroup = $Person.StaffGroup

# Set Password To Expire

Set-ADUser $Username -PasswordNeverExpires $false

# Set New Password

Set-ADAccountPassword $Username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force -Verbose) -PassThru

# Set Change Password At Login

Set-ADUser $Username -changepasswordatlogon $true

}