Goal: Automate the unboarding process for new employees by bulk-importing users from a CSV file into Active Directory

Purpose:
  Scalabilty:  Whether onboarding 5 users or 100 users the script remains the saame
  Standardization:  Ensures every user account is created with the same attributes 

Exeuction Notes:
  Remote Execution:  The script is run from Client-01 using the Powershell module in RSAT.  
  Department Sorting:  The script uses Switch logic (somewhat similar to an IF/Else in Python) to assess each user's 'Department' attribute and place them in the correct OU

Notes on the Script: The script mostly exists to reshape the CSV data, especially Department, into Distinguished Names and other formats that New-ADUser strictly requires.

Part 1: Preparation (Client Machine)
  1. Create New OUs
     - Open AD Users and Computers
     - Right click DemoCorp > New > Organization Unit
     - Create three new OUs (names need to be exact to match the script)
        - Sales_Department
        - IT_Department
        - Accounting_Department
 
  2. Discover your OU Paths (Distingushed Names)
     - You need the exact 'Distingushed Name' (DN) of your target OUs to tell the script where to put users
     - Open AD Users and Computers > Click View > Advanced features
     - Right click the IT_Department OU > Properties > Attribute Editor tab > find distinguishedName > Copy at least one for later (eg OU=IT_Department,OU=DemoCorp,DC=ad,DC=lab)

  3. Create a CSV File
     - Open Notepad
     - Create headers: FirstName, LastName, SamAccountName, Department, Password
     - Add 5-10 dummy users (Make sure every deparment has a user and you can use job titles to help with names)
     - Save the file as C:\Temp\NewUsers.csv on the client machine

Part 2: The Script 
  - I have included the script in the script folder and there is annotation on the script.
  - Things that stand out
    - Use of Distinguished Names (DN) which are required by the New-ADUser cmdlet.
    - Use of a Switch to sort the csv Department attribute into the required DN format
    - 


