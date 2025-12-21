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
  3. The Handshake: click SAML Configuration in the top menu > Click Create
     - Login URL: https://login.microsoftonline.com/e08d54e3-52c6-478b-b13d-18eb69911e64/saml2 (URL from Entra Section 4)
     - Azure AD Identifier: https://sts.windows.net/e08d54e3-52c6-478b-b13d-18eb69911e64/ (Microsoft Entra Indentifier from Section 4)
     - Logout URL: https://login.microsoftonline.com/e08d54e3-52c6-478b-b13d-18eb69911e64/saml2 (Section 4)
     - Certificate RAW: Choose File > Microsoft Entra SAML Toolkit.cer (saved earlier)
     - Click Create

Part 4: Verification
  1. The 'Magic' Link:
     * After you click Create on SAML 2.0 Single sign-on Configuration you get the field below to be populated
     - SP Initiated Login URL: https://samltoolkit.azurewebsites.net/SAML/Login/20737
  2. Demo:
     - Paste the URL into a Private/Incognito browser
     - You should be taken to website that says: Use a SAML SSO to log in > then displays Your Connection Identifier = 20737
     - You will be asked to log in to your Entra ID account > Make sure to use your synced Entra ID user (ie daccounts@ADLab026.onmicrosoft.com)
     - You will be redirected back to the app, logged in automatically - you will not need to log in with the website username and password you created before


  


  
