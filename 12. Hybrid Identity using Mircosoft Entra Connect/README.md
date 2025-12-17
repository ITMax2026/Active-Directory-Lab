Goal: Establish a Hybrid Identity by synchronizing on-premise Active Directory Users and Groups to Microsoft Entra ID.  
  - This enables a modern Single Sign-On (SSO) experience, where users are able to access cloud resources (Office 365, Teams, OneDrive, etc) with their existing on-prem credentials

Architecture Strategy: Dedicated AADC Server
  - Instead of installing Microsoft Entra Connect directly on the Domain Controller, an increase in attack surface, we deployed a dedicated a dedicated Member Server (AADC-01)
  - This adheres to the principle of Least Priviledge by keeping the Domain Controller directly untouched and locked down

Security Setup: Hardened Installation
  - IE Enhanced Security Configuration: We did not disable server security globally.
  - Instead specific, common Microsoft endpoints were whitelisted to allow syncronization and authentication while keeping the server secure
    * I found a list of 4 suggested URLs to whitelist, but during the actual setup the installer prompted me to whitelist around 10 more URLs, which I did
   
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

Step 4: Configure Networking and Join the Domain
  1. Networking:
     - Windows + r > ncpa.cpl
     - Right-click the adapter > Properties > Click Internet Protocol Version 4 (TCP/IP) and select Properties.
     - Click Use the following IP address:
        IP address: 192.168.242.11 (You can set as your desired static IP).
        Subnet mask: 255.255.255.0
        Default gateway: 192.168.242.2 (Make sure this matches the gateway found in the ipconfig check earlier).
     - Click Use the following DNS server addresses:
        Preferred DNS server: 192.168.242.10
   2. Join the Domain
     
     
