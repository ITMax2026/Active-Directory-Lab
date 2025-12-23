The goal of this section is to make users aware of the conflicts that will arise with Microsoft default security settings, why they are in place, and how to manage this issue.

***

### **1. The Operational Challenge**

1.  The project goal was to implement a "Smart" security posture, requiring MFA for most access but relaxing it for **Trusted Locations** (e.g., the secure home lab network).
2.  However, I found that our attempts to customize these rules were being overridden by Microsoft’s pre-configured "**Security Defaults**" and **Microsoft-managed Conditional Access policies**.
3.  Later, I realized this rigidity would also impact **Part 15 (Intune)**, where these same default policies would block devices from silently enrolling in management.

***

### **2. Understanding the Defaults - Two Overlapping Layers**

1.  **Security Defaults**
    *   Microsoft Entra ID comes with '**Security Defaults**' enabled.
    *   **Philosophy**: Microsoft has explicitly stated it is for small organizations without dedicated IT or security staff.
    *   When enabled, it automatically applies:
        *   Mandatory MFA for: **All admins** and **All users**.
        *   Blocking legacy authentication (POP, IMAP, basic auth).
        *   Protection of privileged accounts.
        *   Basic identity risk mitigation.
    *   *Note: You cannot tune these settings individually.*

2.  **Microsoft-managed Conditional Access policies** (Turned on by default)
    *   Block legacy authentication.
    *   Multifactor authentication for admins.
    *   Multifactor authentication for all users.
    *   Multifactor authentication for Azure management.
    *   *Microsoft also gives you active warnings about preventing 99.5% of attacks if you try to turn these policies off.*

***

### **3. Security Management**

1.  **Decommissioning Defaults:**
    *   Explicitly disable **Security Defaults**.

![Security Defaults](./images/security-defaults.png)

    *   Explicitly disable all three **Microsoft-managed MFA policies**.

![Microsoft Managed](./images/microsoft-managed.png)
      
2.  **Mirror Protection:**
    *   Build custom Conditional Access policies (`CA01`, `CA02`) that replicate MFA protections but provide granular controls.

![CA1](./ca1.png)

***

| ✅ **Takeaway:** By moving to custom Conditional Access policies, I shifted from a rigid, "block-everything" posture to a flexible, context-aware, and customizable posture. |
| :--- |
