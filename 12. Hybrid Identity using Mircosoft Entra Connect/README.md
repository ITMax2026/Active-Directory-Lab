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

