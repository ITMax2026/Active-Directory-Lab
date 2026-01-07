# Hybrid Active Directory & Cloud Management Lab

This project demonstrates the end-to-end implementation of a modern enterprise IT environment, transitioning from a traditional on-premises Active Directory setup to a Hybrid Cloud model using Microsoft Entra ID and Intune.

![Active Directory Lab Architecture](./images/lab4.png)

## Project Overview
The lab is divided into four phases:

### Phase 1: Foundations
*   **Virtualization:** Deployed Windows Server 2022 and Windows 11 Client via VMware Workstation Pro.
*   **Active Directory (AD DS):** Promoted Server 2022 to a Domain Controller and designed an organizational structure using OUs, Groups, and Users.
*   **Group Policy Objects (GPOs):** Hardened the environment by configuring baseline policies, including an Acceptable Use Policy (AUP) banner and Control Panel restrictions.

### Phase 2: On-Premises Administration
*   **Infrastructure Provisioning:** Implemented automated Folder Share (mapped drives) and a Print Server managed via GPO.
*   **Automation (PowerShell):** Developed and executed a PowerShell script for bulk user creation for Active Directory.
*   **Software Deployment:** Orchestrated automated software installation for a client machine via GPO.
*   **Security:** Configured Remote Server Administration Tools (RSAT) for secure, delegated server management.


### Phase 3: Hybrid & Cloud Identity
*   **Secure Hybrid Setup:** Configured a domain-joined member server and managed IE Enhanced Security settings for secure administrative access.
*   **Entra Connect:** Established a Hybrid Identity model by synchronizing local AD with Microsoft Entra ID.
*   **Identity Resolution:** Resolved the "Two-Identity Problem" by aligning local User Principal Names (UPNs) with Entra ID identities to ensure seamless authentication.
*   **Zero-Trust Security:** Built custom **Conditional Access Policies** enforcing geolocation-based Multi-Factor Authentication (MFA).

### Phase 4: Cloud-Native Management
*   **SSO:** Configured modern SaaS application access using SAML Single Sign-On (SSO).
*   **Hybrid Entra ID Join:** Registered domain-joined devices with Entra ID (formerly HAADJ) to enable modern management.
*   **Mobile Device Management (MDM):** Enrolled devices into **Microsoft Intune** to deploy configuration policies and remotely install applications.

---

##  Troubleshooting & Key Lessons

### On-Premises Challenges
*   **Issue:** GPO software deployment failed to trigger on startup.
*   **Root Cause:** The MSI file was added to the GPO incorrectly during the initial setup.
*   **Resolution:** Re-created the GPO with the MSI file correctly loaded, successfully triggering the installation upon the next reboot.

### Cloud & Hybrid Challenges
1.  **Issue:** Client-01 failed to appear in Entra ID, preventing Intune enrollment.
    *   **Root Cause:** A combination of an incomplete Service Connection Point (SCP) registration and a UPN mismatch.  Windows could not issue a Primary Refresh Token (PRT) because the local `@ad.lab` did not match the cloud tenant.
    *   **Resolution:** Updated local UPNs to match the Entra ID domain and re-ran the SCP configuration via Entra Connect.
2.  **Issue:** Default MFA settings were conflicting with custom policies.
    *   **Resolution:** Disabled "Security Defaults" in the Entra admin center to allow for more granular Conditional Access Policies.
3.  **Issue:** Intune Enrollment app is not natively supported for manual installation.
    *   **Resolution:** Utilized **Microsoft Graph PowerShell/Explorer** to manually instantiate the Service Principal.

---

##  Lab Evolution & Future Work

### 1. Script Editing & Hashtable/Splatting
Refactored the initial user creation script to improve efficiency and scalability:
*   Updated the `$Domain` variable to automate cloud-ready UPN assignment.
*   Implemented **Splatting** and a Hashtable lookup to handle lenghtly parameter sorting for OU and Group assignments, making the code more readable.

### 2. Transition to Cloud-Native (Entra Joined)
Tested the transition from Hybrid-Join to **Full Entra Join**:
*   **Takeaway:** Discovered that Entra-joined devices lose local GPOs but gain full management via Intune Configuration Profiles.
*   **Resource Migration:** Successfully migrated local file shares to **SharePoint Online**, providing cloud-synced access without the need for a local VPN or DC connection.

### 3. Future Graph API Integration
Explore the use of **Microsoft Graph PowerShell** for direct cloud provisioning.  Because Graph runs over HTTPS (vs. LDAP for AD), it is required for automated identity management in Entra ID cloud-only environments.

---

##  Resources
*   Microsoft Documentation (Learn), YouTube Videos, Google searches, and Gemini Q&A
*   *Note: Gemini AI was utilized for Markdown formatting.*

