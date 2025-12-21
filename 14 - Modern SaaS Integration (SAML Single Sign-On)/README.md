Goal: Centralize identity management and enable Single Sign-On by federating a third-party Saas application (SAML Toolkit) with Microsoft Entra ID using SAML 2.0

Deployment Strategy:
  1. Federated Identity Bridge: 
    - Establish a trush relationship betweeen the Identity Provider (Entra ID) and the Service Provider (SAML Toolket)
    - This eliminates the need for seperate service credentials
  2. Certificate-based Security:
    - Authentication is secured via Base64 RAW certificate. 
    - This ensures that the SaaS application only accepts tokens signed by the corporate directory
  3. Least Priviledge Assignment: 
    - Only specific identies (ie Bob Builder) are assigned to the application
  
Purpose: 
  1. Identity Consolidation
    - By using SSO, we eliminate 'password fatigue' and the risk of weak password resuse across multiple services
  2. Centralized Lifecycle Management: 
    - Provides centralized access control; disabling a users in Entra ID disables their access to all integrated SaaS applications (Salesforce, Slack, etc)

Part 1: Provision the SaaS Application
  1. In Microsoft Entra Admin Center go to Entra ID > Enterprise Applications > select + New Application
  2. 
