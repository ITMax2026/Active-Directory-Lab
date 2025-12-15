#1. Import the Active Directory Module
Import-Module ActiveDirectory
 
#2. Set the path to the CSV file
$CSVFilePath = "C:\Temp\NewUsers.csv"
 
#3 Import the csv data
$Users = Import-Csv $CSVFilePath
 
#4. Config
$Domain = "@ad.lab"
 
#5. Define paths for OUs  - Active Directory reads right to left
# All the paths share this inital path, so this is a Directory root keep code clean
# Distinguished Name (DN) represents the shared path
$BaseDN = "OU=DemoCorp,DC=ad,DC=lab"
 
$AdminOU = "OU=Admin_Department,$BaseDN"
$SalesOU = "OU=Sales_Department,$BaseDN"
$ITOU    = "OU=IT_Department,$BaseDN"
$AcctOU   = "OU=Accounting_Department,$BaseDN"
$StaffOU   = "OU=General_Staff,$BaseDN"
 
 
#6. Start a loop - Will go line by line through the NewUsers csv file
foreach ($Person in $Users) {
 
    #7. Password Conversion - AD doesn't accept a password in plaintext. 
    # The following command converts it into an encrypted "SecureString"
    # This is a very common,  general PowerShell line
    $SecurePass = ConvertTo-SecureString $Person.Password -AsPlainText -Force
 
    #8. Switch Statement - assesses the 'Department' variable for the current $Person
    switch ($Person.Department) {
        "Admin"      { $UserOU = $AdminOU }
        "Sales"      { $UserOU = $SalesOU }
        "IT"         { $UserOU = $ITOU }
        "Accounting" { $UserOU = $AcctOU }
 
        # 'Default' catches any user who doesn't match the categories above, it also helps catch typos
        Default      { $UserOU = $StaffOU }
    }
 
    #9. Creaing the User: 
    # backtick(`) creates a line continuation and is standard in New-ADUser setups
    # the attributes after the dash to start the line are build in Powershell user objects for AD
 
    # Name expects a string, the double $() wrapping is to help with Powershell string interpolation
    New-ADUser  -Name "$($Person.FirstName) $($Person.LastName)" `
                    -GivenName $Person.FirstName `
                    -Surname $Person.LastName `
                    -SamAccountName $Person.SamAccountName `
                    -UserPrincipalName ($Person.SamAccountName + $Domain) `
                    -Path $UserOU `
                    -Department $Person.Department `
                    -AccountPassword $SecurePass `
                    -Enabled $true `
 
}