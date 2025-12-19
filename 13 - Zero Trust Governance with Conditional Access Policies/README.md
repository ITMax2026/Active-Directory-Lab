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

Part 3: Conflict Resolution
  * We need to not only disable Security Defaults but also Deactive default Microsoft-managed conditional access policies
  1. 


Part 4
