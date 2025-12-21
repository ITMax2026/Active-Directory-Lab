Goal:

Part 1: Configure the Service Connection Point (SCP)
  * Before Intune can manage the device, Entra ID needs to see the device
  1. Log into AADC-01 - the Entra Connect Server
  2. Open Microsoft Entra Connect > Click Configure
  3. Select Configure device options > Next
  4. Connect to Entra ID join with you admin account and password
  5. Device Options: Configure Hybrid Microsoft Entra ID join
  6. Device Operating System: Windows 10 or later
  7. SCP Configuration
     - Select ad.lab
     - Authentication Service: Microsoft Entra ID
    *The SCP creates a record in Active Directory of your specific Tenant ID (Azure GUID) and Tenand Domain Name (ie ADLabs026.onmicrosoft.com)
    *Of Note:
      -SCP handles the Computer's Map - it's tell the physical hardware (Client-01) they are Hybrid Joined - result AzureADJoined: Yes
      -UPN handles the User's Credentials - it allows a User (Jeff Admin) to prove who he is to the cloud - result AzureADPrt: Yes
        *If you don't follow the instructions in section 12.5 you will try to log in with @ad.lab which isn't a real internet domain and you won't get a PRT

