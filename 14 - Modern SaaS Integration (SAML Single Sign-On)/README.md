Goal: Centralize identity management and enable Single Sign-On by federating a third-party Saas application (SAML Toolkit) with Microsoft Entra ID using SAML 2.0

Deployment Strategy:
  1. Federated Identity Bridge: 
    - Establish a trush relationship betweeen the Identity Provider (Entra ID) and the Service Provider (SAML Toolket)
    - This eliminates the need for seperate service credentials
  2. Certificate-based Security:
    - Authentication is secured via Base64 RAW certificate. 
    - This ensures that the SaaS application only accepts tokens signed by the corporate directory
  3. Least Priviledge Assignment: 
    - Only specific identies (ie David Accounts) are assigned to the application
  
Purpose: 
  1. Identity Consolidation
    - By using SSO, we eliminate 'password fatigue' and the risk of weak password resuse across multiple services
  2. Centralized Lifecycle Management: 
    - Provides centralized access control; disabling a users in Entra ID disables their access to all integrated SaaS applications (Salesforce, Slack, etc)

Part 1: Provision the SaaS Application
  1. In Microsoft Entra Admin Center go to Entra ID > Enterprise Applications > select + New Application
  2. Search for Microsoft Entra SAML Toolkit
  3. Click Create.
  4. Click into the App > Assign Users and Groups > > Add User/Group > Click None Selected under Users and Groups
  5. Add your User (ie Bob Builder)

Part 2: Configure the Identity Provider (IdP) - (Microsoft Entra ID)
  * https://learn.microsoft.com/en-us/entra/identity/saas-apps/saml-toolkit-tutorial - This website is a good guide
  1. Select Single Sign-On > SAML
  2. Edit Basic SAML Configuration (Section 1):
     - Identifier (Entity ID): https://samltoolkit.azurewebsites.net (This should already be filled in)
     - Reply URL: https://samltoolkit.azurewebsites.net/SAML/Consume
     - Sign on URL: https://samltoolkit.azurewebsites.net/
  3. SAML Certificates (Section 3): Download the Certificate (Raw) into downloads
  4. SAML Toolkit (Section 4): You will need this info for later

Part 3: Configure the Service Provider (SaaS App)
  * Most SAML apps require you to help provision bu entering Cloud/Microsoft details into their admin portals
  1. Go to https://samltoolkit.azurewebsites.net/
  2. Register User: Click Register and create an account with the email address of a synced Entra ID user (ie daccounts@ADLab026.onmicrosoft.com)
  3. 

  


  
