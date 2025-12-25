# Lab: Secure Shared Drive Deployment

**Goal:** Create a drive (S:) on the domain controller that other users can access.

**Security Model:**
*   **Share Permissions:** Authenticated Users = Full Control
    *   *Note: It is too cumbersome to manage security at two levels. So at the Share level we provide minimal screening and let NTFS handle security inside.*
*   **NTFS Permission:** Hardened security where Principle of Least Privilege applies.
*   **Access-Based Enumeration (ABE):** If a user doesn't have folder permission, the folder is hidden.

**Root Lock:**
*   The **S:\** drive root is secured with domain read access to prevent accidental access or misconfiguration, while NTFS permissions on subfolders enforce least-privilege access.

***

### 1. Verify Identity/Setup (Optional)

1.  Open **ADUC (Active Directory Users and Computers)**.
2.  Check **John HR**:
    *   DemoCorp > General_Staff (OU)
    *   Open **John HR** > **Member Of** tab > Verify **G_HR_Staff**
3.  Check **Jeff Admin**:
    *   DemoCorp > Admin_Department (OU)
    *   Open **Jeff Admin** > **Member Of** tab > Verify **G_IT_Admins**
4.  Create New Legal OU, User, and Security Group:
    *   Right-click **DemoCorp** > **New** > **Organization Unit** > **Legal_Department**
    *   Right-click the OU > **New** > **User** > First Name: **Jenny**, Last Name: **Law**, User log on: **jlaw**
    *   Right-click Groups OU > **New** > **Group** > Group Name: **G_Legal_Staff**, Scope: **Global**, Type: **Security**
    *   Right-click the **G_Legal_Staff** group > **Properties** > **Members** > **Add** > search for **jlaw** > **OK**

### 2. Create Shared Folders

1.  Log into **DC01**.
2.  Open File Explorer and navigate to **C:\**.
3.  Create a new Folder: Name it **CorpData**.
4.  Inside **CorpData** > Create two subfolders:
    *   **HR_Data**
    *   **IT_Data**
    *   **Legal_Data**

### 3. Open Share, Closed NTFS

**Step 1: Open Share**
1.  Right-click **C:\CorpData** > **Properties** > **Sharing** > **Advanced Sharing**.
2.  Check **Share this folder**.
3.  Share Name: **CorpData**
4.  Click **Permissions** Button:
    *   Remove **Everyone**
    *   Add **Authenticated Users**
    *   Check **Full Control**
    *   *Note: This lets anyone connected to the network access the Share. We are going to let NTFS handle file/folder level security.*

![Open Share](./images/open-share.png)

**Step 2: NTFS Root Lock**
1.  Right-click **C:\CorpData** > **Properties** > **Security** > **Advanced**.
2.  **Disable Inheritance** > "**Convert inherited permissions into explicit permissions**".
    *   *Note: Subfolders keep same permissions they have right now, but will have independent permissions than the parent folder going forward.*
3.  Permission Clean Up:
    *   Keep **SYSTEM** and **Administrators** (Full Control)
    *   Remove **Users** (local)
4.  Access Permission (for Everyone):
    *   Click **Add** > **Select a principal** > **Domain Users**
    *   Type: **Allow**
    *   Applies to: **This folder only**
    *   Basic Permissions: **Read & Execute, List folder contents, Read**
    *   Click **OK**
    *   *Note: Root Lock keeps S:\ clean and limits future permission mistakes.*

![Corpdata Permissions](./images/corpdata-permissions.png)

**Step 3: Closed NTFS - Subfolder Level**
1.  **Secure HR_Data**
    1.  Right-click **C:\CorpData\HR_Data** > **Properties** > **Security** > **Advanced**.
    2.  **Disable Inheritance** > **Convert to explicit**.
    3.  **Edit** (Groups or User Names):
        *   Remove **Domain Users**
        *   Add **G_HR_Staff**
        *   Permission: **Modify**

![HR Permissions](./images/hr-permissions.png)

2.  **Secure IT_Data**
    1.  Right-click **C:\CorpData\IT_Data** > **Properties** > **Security** > **Advanced**.
    2.  **Disable Inheritance** > **Convert to explicit**.
    3.  **Edit** (Groups or User Names):
        *   Remove **Domain Users**
        *   Add **G_IT_Admins**
        *   Permission: **Modify**

3.  **Secure Legal_Data**
    1.  Right-click **C:\CorpData\Legal_Data** > **Properties** > **Security** > **Advanced**.
    2.  **Disable Inheritance** > **Convert to explicit**.
    3.  **Edit** (Groups or User Names):
        *   Remove **Domain Users**
        *   Add **G_Legal_Staff**
        *   Permission: **Modify**

### 4. Turn on Access-Based Enumeration (ABE)

*When this is turned off John HR will see the IT_Data folder but get an error when clicking it; when it is on, John won't be able to see the folder.*

1.  Open **Server Manager**.
2.  **File and Storage Services** > **Shares**.
3.  Right-click **CorpData** > **Properties** > **Settings**.
4.  Check **Enable access-based enumeration**.

![ABE](./images/abe.png)

### 5. Group Policy Drive Mapping

*Following the Open Share, Closed NTFS policy, we are linking the Drive Mapping GPO to the DemoCorp OU so it applies to all Users and permissions are handled by NTFS.*

1.  Open **Group Policy Management** on DC01.
2.  Right-click **DemoCorp** OU > **Create a GPO in this domain, and Link it here...**
3.  Name: **U_DriveMap_CorpData** (*We are using a User policy, as User Group membership (i.e. G_HR_Staff) will manage permissions*).
4.  Right-click the new GPO > **Edit**.
5.  **User Configuration** > **Preferences** > **Windows Settings** > **Drive Maps**.
6.  Right-click white area > **New** > **Mapped Drive**.

![Drive Map](./images/drive-maps.png)

**General Tab:**
*   Action: **Update**
*   Location: **\\DC01.ad.lab\CorpData**
*   Reconnect: **Checked**
*   Label: **DemoCorp Shared Data**
*   Drive Letter: **S:**

![GPO Drive General](./images/gpo--drive-general.png)

**Common Tab:**
*   Check **Run in logged-on user's security context**
*   *Note: We did not use any Item-level targeting because permissions are handled by the folders themselves (NTFS), not the GPO.*

![GPO Drive Common](./images/gpo-drive-common.png)

### 6. Verification

**Test 1: HR User (John HR)**
1.  Log into Client-01 as **ad.lab/John HR (jhr)**.
2.  Open File Explorer. You should see the **S:** drive - **DemoCorp Shared Drive**.
3.  Visibility test:
    *   You should see **HR_Data**; you should not see **IT_Data** (Because of ABE).
4.  'Root Lock' test: Open **S:** and try to create **test.txt** in the root.

![HR Access](./images/hr-access.png)

![Access Denied](./images/access-denied.png)


    ✅ **Success Criteria:** You should see 'Destination Folder Access Denied'.

**Test 2: Admin User (Jeff Admin)**
1.  Still on the client log out and log in as **Jeff Admin**.
2.  Open **S:**.
3.  You should see both **HR_Data** and **IT_Data**.

![Admin Access](./images/admin-access.png)

    ✅ **Success Criteria:** Jeff is a Domain Admin and is able to bypass NTFS Restrictions (plus we allowed Administrators earlier).

**Test 3: Legal Staff**
1.  Log in as **Jenny Law (jlaw)**.
2.  Open **S:**.

![Legal Access](./images/legal-access.png)

    ✅ **Success Criteria:** You should see **Legal_Data**.

### 7. Return after Lab 9 (Bulk User creation is complete) - Create a Public shared folder for all Users

1.  Go to **DC01**.
2.  Open **C:\CorpData** > Create a new folder named: **Public - DemoCorp**.
3.  Right-click the folder > **Properties** > **Security**.
4.  **Edit** > **Add**.
5.  Type **Domain Users** > **Check Names** > **OK**.
6.  Default permissions are fine: **Read & execute** (*User can read files but not modify*).
    *   *This is helpful for Company Wide Announcements and General Information.*

    ✅ **Success Criteria:** Next time a domain joined User opens their S: drive they'll see Public - DemoCorp.
