### **1. Hybrid Identity Architecture: The Goal**

The goal is to enable seamless synchronization, authentication, and single sign-on across hybrid environments.

*   **User Principal Name (UPN)** is the primary login identifier.
*   **Microsoft Entra ID** and **Entra Connect** rely on the UPN to:
    *   Uniquely match on-premises and cloud user objects.
    *   Authenticate users.
    *   Enable **Single Sign-On (SSO)**.
*   *Note: If UPNs differ between on-premises and Cloud, identity correlation does not work.*

---

### **2. Problem Identification & Context**

**Problem:** 
During initial synchronization, my on-premises **Active Directory** was configured with a non-routable domain (`@ad.lab`), while my **Microsoft 365 tenant** used a public, routable domain (`@ADLab026.onmicrosoft.com`). **Microsoft Entra Connect** automatically changed the non-routable suffix, replacing it with the tenant's default domain. This resulted in mismatched login credentials (i.e., `user@ad.lab` vs `user@ADLab026.onmicrosoft.com`).

**Legacy Enterprise Environment Context:**
Historically, organizations were encouraged to use internal-only domains (like `.corp` or `.local`). However, modern **Cloud Identity** standards (**SAML**, **OAuth**, **OIDC**) require publicly verifiable, routable domains.

---

### **3. Solution: Align Local AD to the Cloud (Manual Process)**

1. On **DC01**: Open **Active Directory Domains and Trusts**.
2. Right-click **Active Directory Domains and Trusts [DC01.ab.lab]** > **Properties**.
3. Add suffix — Type: `ADLab026.onmicrosoft.com`.
4. **Update Users:** Go to **Active Directory Users and Computers** (There are several ways to automate this, but for these 8 users, I did it manually).
    *   Right-click a user (e.g., `Frank ActiveDir` or `Alice Admin`) > **Properties**.
    *   Go to the **Account** tab.
    *   Change the dropdown from `@ad.lab` to `@ADLab026.onmicrosoft.com`.
    *   Click **OK**.
5. **Force Sync:** On **AADC-01**, open **PowerShell** and run:
    *   `Start-ADSyncSyncCycle -PolicyType Delta`

| &nbsp; | ✅ **Success Criteria:** The on-premises UPN suffix should now match the Microsoft Entra ID primary domain. |
| :--- | :--- |

---

### **4. Verification of Results**

Confirm that the login identifiers are now synchronized across both environments.

1. **Locally:** Frank logs in as `factivedir@ADLab026.onmicrosoft.com`.
2. **Cloud:** Frank logs in as `factivedir@ADLab026.onmicrosoft.com`.

`[Final Sync Verification Screenshot]`

| &nbsp; | ✅ **Success Criteria:** Seamless authentication is achieved using a single, consistent UPN for both local and cloud resources. |
| :--- | :--- |
