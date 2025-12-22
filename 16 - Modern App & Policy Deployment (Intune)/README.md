# Lab: Transitioning to Microsoft Intune

**Objective:**
Transition device management from legacy on-premises Group Policy (GPO) to Microsoft Intune. Show that security policies and software could be successfully deployed to a Hybrid-joined device over the open internet.

**Purpose:**
As organizations shift more towards remote and hybrid work, relying on local Domain Controllers for policy configuration is no longer suitable.

**Why Intune is winning over Active Directory GPO:**
*   In an on-prem environment, a computer had to be on the office Wi-Fi or a VPN to get a GPO update.
*   If a user stayed home for a month, their computer became unmanaged and unpatched.

---

### 1. Configure Modern GPO (Device Hardening)

1. Navigate to **Intune Admin Center** > **Devices** > **Configuration** > **Create** > **New Policy**.
2. Select **Platform**: `Windows 10 and later`.
3. Select **Profile Type**: `Settings Catalog`.
4. Set **Name**: `Win - Security - Block Camera`.
5. Under **Configuration Settings**:
    *   Click **Add Setting** > **Settings Picker**.
    *   Search for `Camera` and select it.
    *   Check the box for **Allow Camera**.
    *   Set the **Allow Camera** toggle to **Not Allowed**.
6. Under **Assignments**:
    *   Select **Add Groups** > Click `Lab Devices`.

[Modern GPO Configuration Screenshot]

> | ✅ **Success Criteria:** The policy is created and assigned to the "Lab Devices" group within the Settings Catalog.

---

### 2. Automated Provisioning (App Deployment)

1. Navigate to **Intune Admin Center** > **Apps** > **Windows** > **Create**.
2. Select **App Type**: `Microsoft Store app (new)` > Click **Select**.
3. Search for: `Company Portal` > Click **Select**.
4. Under **Assignments**:
    *   **Required**: Click **Add Groups** and select the `Lab Devices` group.
5. Click **Next** > **Create**.

[Cloud Install Configuration Screenshot]

> | ✅ **Success Criteria:** The Company Portal app is successfully added to the Intune library and assigned as a required deployment.

---

### 3. Verification and Testing

1. Log into `Client-01`.
2. **Force the Sync**:
    *   Go to **Settings** > **Accounts** > **Access work or school**.
    *   Click **Info** > Click **Sync**.
3. **Test the Camera**:
    *   Open the **Camera** app.
4. **Test the App Deployment**:
    *   Check the **Start Menu** for the **Company Portal** app. (Note: App files can be large, so it may take 5-10 minutes to appear).

[Policy and App Verification Screenshot]

> | ✅ **Success Criteria (Camera):** The app should display: "We Can't Find Your Camera" with error code `0xA00F4244`.
> | ✅ **Success Criteria (App):** The Company Portal application appears in the Start Menu without manual user intervention.
