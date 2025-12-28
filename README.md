Hybrid Active Directory & Cloud Management Lab



Phase 1 - Foundations - Sections 1-6:  
  - Virtualization:  Started by initially setting up a Windows Server 2022 then a Windows 11 client on VMWare Workstation Pro
  - Active Directory: Promoted the Windows Server 2022 to a Domain Controller, and organized the environment using OUs, Groups and Users
  - Group Policy Objects (GPOs):  Configured two baseline GPOs (Acceeptable User Policy banner and Control Panel lockout) and, after connecting a client to the domain, verified the policies were correctly being applied
    
Phase 2 - On-Premise Administration - Sections 7-11:
  - Infrastructure Provisioning:  Implemented Folder Shares (mapped drive) and a Print Server via GPO
  - Security: Set up RSAT for Server security
  - Automation (User Creation): Deployed a Powershell script for bulk user creation in AD 
  - Automation (Software Deployment): Installed business software on client machines using GPOs

Phase 3 - Hybrid & Cloud Identity - Section 12-13.5:
  - Secure Hybrid Setup: Maintained IE Enhanced Security Configuration, built domain-joined member server and used RDP for sync configuration
  - Entra Connect: Connected the local AD to the cloud using Microsoft Entra Connect creating a Hybrid Identity
  - Two-Identity Problem: Resolved non-matching UPNs by aligning local identities with Entra ID identities so hybrid syncronization and authentication will work
  - Zero-Trust Cloud: Build custom Conditional Access Policies, aligned with Zero-Trust principles, for geolocation based Multi-Factor Authentication (MFA)
  
