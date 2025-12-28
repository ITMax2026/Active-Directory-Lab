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

===future ideas..direct to cloud powershell...need Microsoft Graph Powershell ...user creation
  - set up sharepoint for cloud shard drive - drive access management
  - - print- tough
    - 
- get experience with Microsoft Graph Powershell

*Resources used to complete this lab include:  YouTube videos, Microsoft articles, Google searches, and Gemini Q&A.  Gemini was used to convert my initial typed writeups into Markdown for presentation and readability.
