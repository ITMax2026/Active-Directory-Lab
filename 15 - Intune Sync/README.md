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

Part 2: Computer Object Syncronization (Checking work implemented in step 12)
  1. In the cloud > Go to Entra Admin Center > Devices > All Devices
  2. Search for Client-01: It should be there
  3. Search of AADC-01: It should not be there
     - Intune is designed for Client OS (Windows 10/11, iOS, Android).  Azure Arc is designed for Servers
     - When you look at 'All Devices' list in the cloud, you want to see all Endpoints (laptops/desktops/mobile), not backend infrastructure
  4. If you don't see Client-01:
      - Open Microsoft Entra Connect from the desktop
      - Click Configure > Customize syncronization options
      - Log in with your Global Admin credentials
      - On the Domain/OU Filtering screen > Ensure 'Workstations' OU is checked
