$UserList=IMPORT-CSV E:\NewStaff2018.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {

# Build Username from ID

$Username=$Person.ID

# Enable Mailbox For User

Get-User $Username | Enable-Mailbox

# Enable Archive For Mailbox

Get-User $Username | Enable-Mailbox

# Enable Retention Policy

Set-Mailbox $Username -RetentionPolicy "Default Archive And Retention Policy"
}