### **Goal: Move a legacy On-Prem Windows 11 Workstation into a Hybrid Joined state (connected to both Active Directory and Entra ID) and have it automatically enroll into Microsoft Intune for cloud management.**

---

### **1. Configure the Service Connection Point (SCP)**
*Before Intune can manage the device, Entra ID needs to see the device.*

1. Log into **AADC-01** — the **Entra Connect Server**.
2. Open **Microsoft Entra Connect** > Click **Configure**.
3. Select **Configure device options** > **Next**.
4. Connect to **Entra ID** join with your admin account and password.
5. Device Options: Select **Configure Hybrid Microsoft Entra ID join**.
6. Device Operating System: **Windows 10 or later**.
7. **SCP Configuration**:
    - Select `ad.lab`
    - Authentication Service: **Microsoft Entra ID**

![Alt text](./images/my-picture.png)

> *The SCP creates a record in Active Directory of your specific Tenant ID (Azure GUID) and Tenant Domain Name (i.e., `ADLabs026.onmicrosoft.com`).*

**Of Note:**
* **SCP** handles the Computer's Map — it tells the physical hardware (`Client-01`) they are Hybrid Joined — result **AzureADJoined: Yes**.
* **UPN** handles the User's Credentials — it allows a User (**Jeff Admin**) to prove who he is to the cloud — result **AzureADPrt: Yes**.
* *If you don't follow the instructions in section 12.5, you will try to log in with `@ad.lab` which isn't a real internet domain and you won't get a PRT - This will block Intune enrollment.*

✅ **Success Criteria:** The SCP configuration completes successfully, allowing the workstation to discover the Entra ID tenant.

---

### **2. Computer Object Synchronization**
*(Checking work implemented in Lab 12)*

1. In the cloud > Go to **Entra Admin Center** > **Devices** > **All Devices**.
2. Search for `Client-01`: It should be there.
3. Search for `AADC-01`: It should **not** be there.
    - **Intune** is designed for Client OS (**Windows 10/11, iOS, Android**). **Azure Arc** is designed for Servers.
    - When you look at the **'All Devices'** list in the cloud, you want to see all Endpoints (laptops/desktops/mobile), not backend infrastructure.
4. **If you don't see Client-01:**
    - Open **Microsoft Entra Connect** from the desktop.
    - Click **Configure** > **Customize synchronization options**.
    - Log in with your **Global Admin** credentials.
    - On the **Domain/OU Filtering** screen > Ensure the **'Workstations' OU** is checked.

✅ **Success Criteria:** `Client-01` appears in the Entra ID "All Devices" list with a Join Type of "Microsoft Entra hybrid joined."

---

### **3. Automated Enrollment via Group Policy (GPO)**
*This policy creates a link to computers in the Workstations OU and automatically enrolls them in MDM (Microsoft Intune).*

1. Go to the **Group Policy Management Console** on **DC01**.
2. Create a new **GPO** named "**Intune Auto Enrollment**" linked to the **Workstations OU**.
3. **Policy Path:**
    - **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **MDM**
4. **Setting:**
    - Select **Enabled**: "**Enable automatic MDM enrollment using default Microsoft Entra credentials**"
    - Select **Credential Type**: **User Credentials**

✅ **Success Criteria:** The GPO is linked correctly and the policy setting is set to "Enabled" using User Credentials.

![Alt text](./images/my-picture.png)

---

### **4. Verification**

1. **Native Diagnostic:**
    - Run `dsregcmd /status` in Command Prompt.
    - Confirm **AzureAdJoined: YES** (Hybrid link active).
    - Confirm **AzureAdPrt: YES** (User Identity Authenticated).
    - Confirm **MdmUrl** populated (MDM discovery successful).

![Alt text](./images/my-picture.png)

2. **Device UI:**
    - Go to **Settings** > **Accounts** > **Access work or school**.
    - Click on the account and confirm the presence of the **'Info'** button.

✅ **Success Criteria:** The `dsregcmd` output shows YES for both Join and PRT status, and the 'Info' button is visible in Settings.
