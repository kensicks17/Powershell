# Import Quest Active Directory Module

Import-Module ActiveDirectory

# Add Quest ActiveRoles Snapin

Add-PSSnapin Quest.ActiveRoles.ADManagement

# Set Signing Policy

# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV E:\CreateStaffUsers\Contacts.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {

# Create the Displayname

$Name=$Person.Firstname+” “+$Person.Lastname+""

# Create User in Active Directory

NEW-QADOBJECT -Type Contact –ParentContainer ‘pcti.tec.nj.us/Phones’ -Name $Person.FirstName -ObjectAttributes @{displayName=$Person.FirstName;givenName=$Person.FirstName;sn=$Person.LastName;IPPhone=$Person.Phone}
}