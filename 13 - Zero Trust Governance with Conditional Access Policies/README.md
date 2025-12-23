Based on the formatting style provided in your image, here is the laboratory guide for implementing the Zero Trust security model.

***

# 1. Part 1: 'Break Glass' Account
*Before enforcing restrictive policies, you must ensure you can never lock yourself out of the tenant.*

1. Log into **Microsoft Entra admin center** - [https://entra.microsoft.com/](https://entra.microsoft.com/)
2. Go to **Entra ID** > **Users** > **Create new user**
    - **User Principal Name**: `breakglass@ADLab026.onmicrosoft.com`
    - **Display Name**: Emergency Admin
    - **Password**: Make it complex and make sure to save it somewhere safe
    - **Assignments**:
        - **Global Administrator**

# 2. Part 2: Define Trusted Location
*We want to tell Entra ID our Office IP Ranges to reduce MFA fatigue.*

1. **Extract IP from Logs**:
    - Navigate to **Entra ID** > **Monitoring & Health** > **Sign-in logs**
    - Find a recent login attempt from a lab machine (e.g., login for `admin@adlab026.onmicrosoft.com`)
    - Look at the **IP address** column: This is the exact address Entra ID 'sees' when you connect.
    * In my case it was an IPv6 address: `2600:382:ba38:3fea:11ca:53a8:1eaa:ffc0`
2. **Configure Named Location**:
    - **Entra ID** > **Conditional Access** > **Named locations**
    - Create a new **IP ranges location** named: **Lab-Trusted-Network**
    - Check **Mark as trusted location**
3. **Add IPs using CIDR notation**:
    - For IPv4: Take the IP from the logs and add `/32`
    - For IPv6: Take the first three groups from the logs and add `::/48`
        - `2600:382:ba38:3fea:11ca:53a8:1eaa:ffc0` > becomes `2600:382:ba38::/48`
    - Click **Create**.

# 3. Part 3: Conflict Resolution
*We need to not only disable Security Defaults but also deactivate default Microsoft-managed conditional access policies. (See section 13.5 for more details).*

1. **Disable Security Defaults**: Go to **Entra ID** > **Overview** > **Properties** > **Manage security defaults** > set to **Disabled**.
2. **Deactivate Microsoft Conditional Access policies**: Go to **Conditional Access** > **Policies**.
    - Set the following Microsoft-managed policies to **Off** or **Report-only**:
        - **Multifactor authentication for all users**
        - **Multifactor authentication for admins**
        - **Multifactor authentication for Azure Management**

# 4. Part 4: Implement Custom Conditional Access Policies

### **Policy 1: Adaptive MFA**
1. **Conditional Access policies** > Click **Create new policy**.
2. **Name**: **CA01: Require MFA for all Users (Excluding Trusted Location)**
3. **Users**: Include **All Users**; Exclude **Emergency Admin**
4. **Target Resources**: **All cloud apps**
5. **Network**: Include: **Any network or location**; Exclude **Selected networks and locations** > **Lab-Trusted-Network**
6. **Grant**: **Grant Access** > click **Require multi-factor authentication**
7. **Enable Policy**: **On**

### **Policy 2: Geoblocking**
1. **Conditional Access policies** > **Named locations** > click **+ Countries location**
    - **Name**: **Blocked-Countries**
    - Select a few countries (e.g., Canada) > Click **Create**.
2. **Conditional Access policies** > **New Policy**
    - **Name**: **CA02: Block Access from Restricted Countries**
    - **Users**: Include **All Users**; Exclude **Emergency Admin**
    - **Target Resources**: **All cloud apps**
    - **Network**: Include: **Selected networks and locations** > Choose **Blocked-Countries**
    - **Grant**: **Block Access**
    - **Enable Policy**: **On**

# 5. Part 5: Validation

1. Open **Incognito/Private browser**.
2. Go to [https://login.microsoftonline.com/](https://login.microsoftonline.com/) and log in with a synced AD user (e.g., `csales@ADLab026.onmicrosoft.com`).

| | |
| :--- | :--- |
| ✅ | **Success Criteria (Policy 1A):** Logging in from a **Home/Trusted Site** allows you to log in with just your password and no popups. |

3. Turn on a **VPN** (moving you out of your Trusted Site) and log in again.

| | |
| :--- | :--- |
| ✅ | **Success Criteria (Policy 1B):** Entra ID will force you to provide Multi-Factor Authentication (MFA). |

4. Use your **VPN** to set your location to one of the countries you blocked (e.g., Canada) and attempt to log in.

| | |
| :--- | :--- |
| ✅ | **Success Criteria (Policy 2):** You should receive a message stating "You cannot access this right now" due to Geoblocking. |
