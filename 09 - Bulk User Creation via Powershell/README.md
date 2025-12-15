Goal: Automate the unboarding process for new employees by bulk-importing users from a CSV file into Active Directory

Purpose:
  Scalabilty:  Whether onboarding 5 users or 100 users the script remains the saame
  Standardization:  Ensures every user account is created with the same attributes 

Exeuction Notes:
  Remote Execution:  The script is run from Client-01 using the Powershell module in RSAT.  
  Department Sorting:  The script uses Switch logic (somewhat similar to an IF/Else in Python) to assess each user's 'Department' attribute and place them in the correct OU

