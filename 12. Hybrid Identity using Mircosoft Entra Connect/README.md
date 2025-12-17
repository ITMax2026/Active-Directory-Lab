Goal: Establish a Hybrid Identity by synchronizing on-premise Active Directory Users and Groups to Microsoft Entra ID.  
  - This enables a modern Single Sign-On (SSO) experience, where users are able to access cloud resources (Office 365, Teams, OneDrive, etc) with their existing on-prem credentials

Architecture Strategy: Dedicated AADC Server
  - Instead of installing Microsoft Entra Connect directly on the Domain Controller, an increase in attack surface, we deployed a dedicated a dedicated Member Server (AADC-01)
  - This adheres to the principle of Least Priviledge by keeping the Domain Controller directly untouched and locked down

Security Setup: Hardened Installation
  - IE Enhanced Security Configuration: We did not disable server security globally.
  - Instead specific, common Microsoft endpoints were whitelisted to allow syncronization and authentication while keeping the server secure
    * I found a list of 10 suggested URLs to whitelist, but during the actual setup the installer prompted me to whitelist around 7 more URLs, which I did

Administrative Install: 
  - Used RDP on the Client-01 VM with an Admini account to install and configure Azure AD Connect/Entra Connect

Authentication Method: Password Hash Synchronization (PHS) with SSO - recommended Microsoft Entra ID hybrid sign-in method
  - Actual passwords are never send to the cloud; a hash of the password is syncronized.

Clean Sync:
  - Only the user/group populated DemoCorp Organization Unit is synced, keeping the cloud environment clean and secure

Step 1: Cloud Setup
  *You need to have Microsoft 365 tenant, acting as a private instance of Microsoft Entra ID, to sync/manage users
  1. Get the Tenant
     - Search for 'Microsoft 365 Business Premium Feel Trial'.  Sign up for a free 30-day trial.  You will need a credit card


      
Step 2: Prepare the Domain Controller


Step 3: Build the Member Server
  *Do this on VMWare
  1. File > New Virtual Machine > Install Windows Server 2022
  2. Configuration Type: Select Typical (recommended).
  3. Guest Operating System Installation:
      Select: I will install the operating system later.
  4. Select a Guest Operating System:
      Select Microsoft Windows and Windows Server 2022.
  5. Virtual Machine Name: AADC-01
  6. Specify disk capacity:
      Maximum disk size: 60 GB (Recommended for Windows Server 2022).
      Select: Split virtual disk into multiple files.
  7. Ready to Create Virtual Machine:
    Memory: 2048 MB
    CPU: 2 cores
  8 Click on the new Windows Server 2022 VM > Click Edit Virtual Machine Settings at the top.
     - Select CD/DVD (SATA).
     - On the right, select Use ISO image file > Browse and select the Windows Server 2022 ISO file.
     - Click OK.

Step 4: Configure Networking and Join the Domain (On the new AADC-01 Server)
  1. Networking:
     - Windows + r > ncpa.cpl
     - Right-click the adapter > Properties > Click Internet Protocol Version 4 (TCP/IP) and select Properties.
     - Click Use the following IP address:
        IP address: 192.168.242.11 (You can set as your desired static IP).
        Subnet mask: 255.255.255.0
        Default gateway: 192.168.242.2 (Make sure this matches the gateway found in the ipconfig check earlier).
     - Click Use the following DNS server addresses:
        Preferred DNS server: 192.168.242.10
   2. Join the Domain:
      - Open Server Manager > Local Server
      - Click on the Workgroup name
      - Click Change
      - Computer Name: AADC-01
      - Member of: Domain: ad.lab (enter Admin credentials when prompted)
      - Restart the server
      - Log in with your Domain Admin account
     
  Step 5: Enable RDP on the Destination (AADC-01)
    1. Server Manager > click Local Server on the left
    2. Remote Desktop likely says Disabled > Click Disabled
    3. Select Allow remote connections on this computer (for now, Uncheck "Allow connections only from computers running Remote Desktop with Network Level Authentication")
    4. Click OK

  Step 6: Download AzureADConnect.msi
      * I had a somewhat hard time finding this file
      1. Download from Microsoft Entra Admin Center > Entra Connect > Manage > Download Connect Sync Agent
  
  Step 7: Client RDP to AADC-01 (On Client-01 VM w/ Jeff Admin user)
    1. Press Win+r > type mstsc
    2. Computer: (Enter the IP address of the new Member Server) 192.168.242.11 - Do Not Connect Yet
    3. Click Shows Options > Local Resources > In the 'Local Devices and Resources' section click More..
    4. Click the check next to Local Disk (C:) > Click OK
    5. Now Connect (Enter Admin credentials)
    6. Accept the warning certificate
    
  Step 8: RDP File Transfer and Setup
    1. Inside the RDP window (showing AADC-01) open File Explorer
    2. Click This PC > You will see C on Client-01
    3. Navigate to Users > jadmin > Downloads 
    4. Drag and drop AzureADConnect.msi onto the AADC-01 desktop

  Step 9: Configure Trust Sites (*This step may be optional because I was still prompted to add several sites to Trusted sites during the install - which worked fine)
    1. Press Win+R > run inetcpl.cpl (Internet Properties)
    2. Security tab > Trusted sites > Sites
    3.  I found this list of sites to Whitelist [Azure portal URLs](https://learn.microsoft.com/en-us/azure/azure-portal/azure-portal-safelist-urls?tabs=public-cloud) 
        login.microsoft.com
        login.microsoftonline.com
        login.live.com
        *.aadcdn.msftauth.net
        *.aadcdn.msftauthimages.net
        *.aadcdn.msauthimages.net
        *.logincdn.msftauth.net
        *.msauth.net
        *.aadcdn.microsoftonline-p.com
        *.microsoftonline-p.com

  Step 10: Install and Configure Entra Connect (performed uding RDP on Client-01
    1. Run the .msi
    2. Customize > Install
    3. User Sign-in: Password Hash Synchronizatoin > Enable Single Sign-On
    4. Connect to Microsoft Entra ID: 
      - Login with your tenant account: admin@...(ADLab026).onmicrosoft.com
    5. Connect Your Directories:
      - Select your local forest (ad.lab)
      - Click Add Directory
      - Select Create new AD account > Enter your Domain Admin credentials (ad.lab\Administrator)
    6. Microsoft Entra Sign-in Configuration:
      - Check "Continue without matching all UPN suffixes to verified domains" (I don't own a public domain that I can verify and this selection is fine for a lab)
    7. OU Filtering
      - Select 'Sync selected domains and OUs'
      - Uncheck ad.lab > Check only DemoCorp
    8.  Click Next through the rest and Install. (You will be prompted to input your Domain Admin credentials to set up SSO - do this)
    
      


    
