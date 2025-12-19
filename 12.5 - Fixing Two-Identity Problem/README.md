Fixing Identity Mismatch: Non-Routable (.lab/.local) vs Routable Domains (ie .com)

Problem:
  - During initial synchonization, my on-premise Active Directory was configured with a non-routable domain (@ad.lab), while my Microsoft 365 tenant used a public, routable domain (@ADLab026.onmicrosoft.com)
  - Microsoft Entra Connect automatically changed the non-routable suffix, replacing it with the tenant's defaul domain.
  - This resulted is mismatched login credentials (ie user@ad.lab vs user@@DLab026.onmicrosoft.com)

Legacy Enterprise Environment Context
  - Historically, organizzations were encouraged to use internal-only domains (like .corp or .local).
  - However, modern Cloud Identity standards (SAML, OAuth, OIDC) require a publicly verifiable, routable domains

The Solution: Align Local AD to the Cloud  (Manual Process)
  1. On DC01: Open Active Directory Domains and Trusts
  2. Right Click ad.lab > Properties
  3. Add suffix - Type: ADLab026@onmicrosoft.com
  4. Update Users: Go to Active Directory Users and Computers (There are several ways to automate this but for these 8 users I did it manually)
     - Right click a User (eg. Frank ActiveDir or Alice Admin) > Properties
     - Go to the Account tab
     - Change the dropdown from @ad.lab to @ADLab026.onmicrosoft.com
     - Click OK
  5. Force Sync: On AADC-01
     - Open powershell and run
     - Start-ADSyncSyncCycle -PolicyType Delta

The Result:
  - Locally: Frank logs in as factivedir@ADLab026.onmicrosoft.com
  - Cloud: Frank logs in as factivedir@ADLab026.onmicrosoft.com
