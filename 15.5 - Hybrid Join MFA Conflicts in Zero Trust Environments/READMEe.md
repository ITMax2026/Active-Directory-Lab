Objective: Deploy Windows Hybrid Azure AD Join and Intune Auto-Enrollment w/ GPO in an environment enforcing 'Strict MFA for All Users

Challenge: The enrollment process fails silently.  While devices successfully register with Entra ID, the MDM (Intune) connection gets lost in silent MFA requests

Solution: Implement a Zero Trust architecture using Conditional Access exclusions.  
  - This allows non-interactive system processes to authenticate via internal verifications while maintaining strict MFA for user sessions
  * This problem was 'solved' in Lab 13 by using Office Location IP exemptions, but this will no work for remote workers

Root Cause: 
  - The GPO was programmed with 'User Credential' enrollment method
  - The Conditional Access policy enforced 'MFA for All Resources'; Entra ID challenged silent enrollment requests.

Architecture Decision:

  Strategy One: Switch to Device Credentials (Often used in very large Orgs) - Rejected
    - Method: Change GPO to enroll using the Computer Object
    - Pro: Bypasses User MFA entirely
    - Con: 
        - Loss of primary user which cases Intune to classify it as a 'Shared Device'
        - Loss of Zero Trust Checks: Conditional Access policies required 'Compliant Devices' fail without an attached User

  Strategy Two: Granular Conditoinal Access Exclusion - Selected
    - Method: Keep User Credentials but whitelist specific Enrollment Resources
    - Pro: Preserves 'Strict MFA' for all apps; adheres to Zero Trust principles
    - Con: Robust configuration as there is missing native support

Part 1: Exposing 'Hidden' Resources
  1. Microsoft Intune Enrollment is not visable in the Entra Conditional Access picker.
  2. Utilized Microsoft Graph to instantiate the Service Principla manually
  3. Go to: https://developer.microsoft.com/en-us/graph/graph-explorer
  4. Set POST https://graph.microsoft.com/v1.0/servicePrincipals
  5. {
     "appId": "d4ebce55-015a-49b5-a083-c84d1797ae8c"
      }
     *This exposes the Intune Enrollement ID for Resource selection
  
Part 2: Configure CA03: Require MFA (Strict + Intune Enrollment Exclusion)
  1. Entra ID > Conditional Access > Policies > Turn Off all other policies
  2. Click +New Policy:
    - Policy Name:  CA03: Require MFA (Strict + Intune Enrollment Exclusion)
    - Users:  All Users (Exclude Break Glass Admin
    - Target Resources:
       - Include: All Resources
       - Exclude:
         1. Microsoft Intune Enrollment (ID: d4ebce55-015a-49b5-a083-c84d1797ae8c)
         2. Microsoft Device Management (ID: ca0a114d-6fbc-46b3-90fa-2ec954794ddb)
    - Access Controls: Grant Access > Require Multifactor Authentication
Technical Note:
  - I discovered that excluding only the Enrollment resource (d4eb...) failed with a "Credentials not verified" error.
  - I identified via Sign-in Logs that the background sync process utilizes a secondary ID (Microsoft Device Management - ca0a...). Adding this second exclusion resolved the sync failure

Part 3: Validation
  1. Client:
     - Settings > Accounts > Access Work or school.
     - Info button should appear
     - Click Info > Sync button should work (This will sync settings, apps, etc with Microsoft Intune)
  2. Zero-Trust
     - Non-Interactive: Background syncs and app installs without user intervention
     - Interactive: MFA is enforced for all log ins
  3. Intune Management GUI:
     - Device visability:  Client-01 appeared in the Intune Admin Center
       
