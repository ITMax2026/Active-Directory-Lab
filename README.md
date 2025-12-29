Hybrid Active Directory & Cloud Management Lab

![Active Directory Lab Architecture](./images/lab4.png)


Phase 1 - Foundations (Sections 1-6):  
  - Virtualization:  Started by initially setting up a Windows Server 2022 then a Windows 11 client on VMWare Workstation Pro
  - Active Directory: Promoted the Windows Server 2022 to a Domain Controller, and organized the environment using OUs, Groups and Users
  - Group Policy Objects (GPOs):  Configured two baseline GPOs (Acceeptable User Policy banner and Control Panel lockout) and, after connecting a client to the domain, verified the policies were correctly being applied
    
Phase 2 - On-Premise Administration (Sections 7-11):
  - Infrastructure Provisioning:  Implemented Folder Shares (mapped drive) and a Print Server via GPO
  - Security: Set up RSAT for Server security
  - Automation (User Creation): Deployed a Powershell script for bulk user creation in AD 
  - Automation (Software Deployment): Installed business software on client machines using GPOs

Phase 3 - Hybrid & Cloud Identity (Section 12-13.5):
  - Secure Hybrid Setup: Maintained IE Enhanced Security Configuration, built domain-joined member server and used RDP for sync configuration
  - Entra Connect: Connected the local AD to the cloud using Microsoft Entra Connect creating a Hybrid Identity
  - Two-Identity Problem: Resolved non-matching UPNs by aligning local identities with Entra ID identities so hybrid syncronization and authentication will work
  - Zero-Trust Cloud: Build custom Conditional Access Policies, aligned with Zero-Trust principles, for geolocation based Multi-Factor Authentication (MFA)
  
Phase 4 - Secure Cloud Integration and Modern Endpoint Management (Section 14-16):
  - SSO: Configured modern SaaS application access using SAML Single Single-On (SSO)
  - Hybrid Entra ID Join: Set up Hybrid Entra ID join (formerly HAADJ) to register domain-joined devices with Entra ID, enabling Intune management
  - MDM: Used Microsoft Intune to demonstrate modern device management with a policy application and a remote app installation



Troubleshooting & Lessons Learned:
On-Prem troubleshooting:  
1.  Isssue: The main issue I encountered was I didn't click to add the msi file to the GPO before i did the software deployment.  I went back to add the msi file to the GPO, which worked, but the software wouldn't deploy on startup.  
    Solution: I created a new GPO and correctly loaded the msi file into the GPO and it worked. I deleted the old one

Cloud troubleshooting:
1.   Issue:  Client-01 was not appearing in Microsoft Entra ID, which was preventing the device from enrolling in Intune via Group Policy.
        The issue was two-fold: an incomplete Hybrid Join process and a UPN mismatch (the "two-identity problem").
        Device Syncing: For a device to sync from Active Directory to the cloud, the computer object must have its userCertificate attribute populated. The device generates this certificate after reading the Service Connection Point (SCP), which it gets from running the Hybrid Microsoft Entra ID join . 
        The UPN Problem: Even if the device object synchronizes, the Hybrid Join cannot complete and Intune enrollment will fail if the local user’s UPN (@ad.lab) does not match the Entra ID UPN (@ADLab025.onmicrosoft.com). Without this match, Windows cannot issue a Primary Refresh Token (PRT), which is the "handshake" required for the device to successfully register and auto-enroll into Intune.
      Solution:
        Device Syncing:  Run the SCP service as part of the Hybrid Microsoft Entra ID join process
        UPN Problem:  Update the UPN on the local AD to match the Entra ID UPN(@ADLab026.onmicrosoft.com)
  
2.  Issue: Default security MFA policies were blocking my Conditional Access policies.  
    Solution:  Disable all of the default MFA Conditional Access policies and make your own, similar but more nuanced, policies
    
3.  Issue: Intune Enrollment app isn't natively supported even thought it is required to maintain MFA and use Intune enrollment
    Solution:  Use Microsoft Graoh Powershell or Explorer to instantiate the Service Principle manually

Future Ideas:
1. User Creation Powershell Script Update
  - After completing the lab I wanted to go back and edit the Powershell script so that when I created new users they would have the correct Entra ID UPN (@ADLab026.onmicrosoft.com) by default
  - I went back and changed the $Domain variable to "@ADLab026.onmicrosoft.com"
  - I was thinking about Entra ID's growing reliance on Groups.  So I wanted to add Group assignment automation to my script.  While researching this I decided to use splatting as well as refactor the OU switch assignment with splatting; I also used splatting for Group assignment.
  - I ran this and it worked as intended (Users created with the Entra ID UPN locally and synced)
2. Client-01 Correctly Syncs
  - I also wanted to try reconnecting the Client-01 and see if it would correctly sync to Entra ID as well as Intune. (*This is where something unexpected happened)
  - I disconnectd the domain connection via Accounts > Access Work
  - I think because I still had the DC connection up the computer was able to establish an internet connection, so when I went to reconnect I was given an option to "Join this device to Microsoft Entra ID" in addition to "Join this device to a local Active Directory domain"  - I chose to try the Entra join because I hadn't used it before
  - I reconnected with an admin (gadmin@ADLab026.onmicrosoft.com) account. 
  3. Entra Joined takeaways:
    - Even with the Domain Controller on, you are no longer in a hybrid environment and you will lose all your existing GPOs; you can check with gpresult /r
    - All existing Intune Configuration policies also automatically pull in to your client
    - It was straight forward to replicate GPOs like AUP popup and Control Panel restriction (targeted by group) using Intune Configuration policies.
    - You will need to set your DNS to automatic again if you want the client to have independent internet unconnected to the DC.  But this means the Client can have full Intune/Entra ID cloud management without requiring any on-prem servers.
    - File Shares and Printers:
        - I successfully moved my demo Folder system to Sharepoint and was able to get cloud sync access (I only had a few dummy .txt files - this can be GB+ for some orgs and be a pain point)
        - I read there is a Universal Print option, but it wasn't easy to test with dummy drives.  So I haven't tested this option.  But I've also read that this can be an even bigger pain point requiring companies to maintain local servers
   4. Cloud Powershell User creation
      - I wanted to try to use powershell to create users direct to the cloud.  This is where I discovered Microsoft Graph Powershell again. (First used for the Intune Enrollment app 
      - To provision services in the cloud you need to use Graph Powershell because  Graph Powershell runs on HTTPS as opposed to LDAP for AD Powershell.
      - I have not attempted this script yet, but learning more about Graph Powershell seems useful



*Resources used to complete this lab include:  YouTube videos, Microsoft articles, Google searches, and Gemini Q&A.  Gemini was used to convert my initial typed writeups into Markdown for presentation and readability.
