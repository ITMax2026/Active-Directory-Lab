Goal: Implement a Zero Trust security model by enforcing Multi-Factor Authentication (MFA) and Geoblocking through Microsoft Entra ID Conditional Access Policies

Deployment Strategy:
  - 'Break Glass' Safety New: Before enforcing restrictions, we establish an emergency, cloud-only administrator account excluded from all policies to prevent accidental tenant lockout
  - Geolocation Authentication:  We define Trusted Locations (the office IP), which reduces MFA fatigue
  - Country Block: If a login originates from a high-risk country, the login is blocked

Purpose: 
  - Identity security: In modern cloud environments, we must verify the identity of the user and the context of the login

Part 1: 'Break Glass' Account
  *Before enforcing restrictive policies, you must ensure you can never lock yourself out of the tenant.
  1. Log into Microsoft Entra admin center - https://entra.microsoft.com/
  2. Go to Entra ID > Users > reate New user
     - User Principle Name: breakglass@ADLab026.onmicrosoft.com
     - Display Name: Emergency Admin
     - Password: Make it complex and make sure to save it somewhere safe
     - Assignments:
       - Global Administator
      
Part 2: Define Trusted Location
  * We want to tell Entra ID our Office IP Ranges to reduce MFA fatigue.
  1. Extract IP from Logs:
     - Navigate to Entra ID > Monitoring & Health > Sign-In Logs
     - Find a recent login attempt from a lab machine (eg login for admin@adlab026.onmicrosoft.com)
     - Look at the IP address column: This is the exact adddress Entra ID 'sees' when you connect
      * In my case it was an IPv6 address: 2600:382:ba38:3fea:11ca:53a8:1eaa:ffc0
  2. Configure Named Location
     - Entra ID > Conditional Access > Named Locations
     - Create a new IP ranges location named: Lab-Trusted-Network
     - Check Mark as trusted location
  3. Add IPs using CIDR notation
     - For IPv4: Take the IP from the logs and add /32
     - For IPv6: Take the first three groups from the logs and add ::/48
         - 2600:382:ba38:3fea:11ca:53a8:1eaa:ffc0 > becomes 2600:382:ba38::/48
     - Click Create

Part 3: Conflict Resolution - There is more about this is section 13.5 
  * We need to not only disable Security Defaults but also Deactive default Microsoft-managed conditional access policies
  1. Disable Security Defaults: Go to Entra ID > Overview > Properties > Manage security defaults > set to Disabled
  2. Deactivate Microsoft Conditional Access policies: Go to Conditional Access (left side) > Policies
     *Set the following Microsoft managed policies to Off or Report-only
     - Multifactor authentication for all users
     - Multifactor authentication for admins
     - Multifactor authentication for Azure Management

Part 4: Implement Custom Conditional Access policies:
  Policy 1: Adaptive MFA
    - Conditional Access policies > Click Create new policy
    - Name: CA01: Require MFA for all Users (Excluding Trusted Location)
    - Users: Include All Users; Exclude Emergency Admin
    - Target Resources: All cloud apps
    - Network: Include: Any network or location; Exclude Selected Networks and locations > Lab-Trusted-Network
    - Grant: Grant Access > click Require Multi-factor authentication
    - Enable Policy: On

   Policy 2: Geoblocking
     - Name: CA02: Block Access from Restricted Countries
     - Users: Include All Users; Exclude Emergency Admin
     - Network: 


Part 5:

https://login.microsoftonline.com/
