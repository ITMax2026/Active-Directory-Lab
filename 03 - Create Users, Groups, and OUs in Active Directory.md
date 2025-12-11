*Scenario: Simulate a sample organization called 'Demo Corp'.*

## Part 1: Create Sample 'Org Chart'
1.  Open **Active Directory Users and Computers (ADUC)**.
2.  Right-click the domain name (`ad.lab`).
3.  Select **New** > **Organization Unit**.
    *   Name it: `DemoCorp_Root`
4.  Right-click the new **DemoCorp_Root** folder and create four sub-OUs:
    *   `Admin_Department` *(for IT Staff)*
    *   `General_Staff` *(for HR, Sales)*
    *   `Workstations` *(for Computers)*
    *   `Groups`

## Part 2: Create the Groups
1.  Right-click the **Groups** OU > **New** > **Group**.
    *   **Group Name:** `G_HR_Staff`
    *   **Scope:** Global
    *   **Type:** Security
2.  Right-click the **Groups** OU > **New** > **Group**.
    *   **Group Name:** `G_IT_Admins`
    *   **Scope:** Global
    *   **Type:** Security

## Part 3: Create the Users
*I will use two contrasting users; one with admin power (Admin) and one who is restricted (Staff).*

### 1. Create a Restricted User
1.  Right-click the **General_Staff** OU > **New** > **User**.
    *   **First Name:** `John`
    *   **Last Name:** `HR`
    *   **User login:** `jhr@ad.lab`
    *   **Password:** `Password123`
2.  **Add to Group:**
    *   Right-click **John HR** > **Properties** > **Member Of** tab > **Add**.
    *   Type `G_HR_Staff` > **OK**.

### 2. Create an Admin
1.  Right-click the **Admin_Department** OU > **New** > **User**.
    *   **First Name:** `Jeff`
    *   **Last Name:** `Admin`
    *   **User login:** `jadmin@ad.lab`
    *   **Password:** `Password123`
2.  **Add to Group:**
    *   Right-click **Jeff Admin** > **Properties** > **Member Of** tab > **Add**.
    *   Type `G_HR_Staff` > **OK**. *(For organizational tracking)*.
    *   Repeat the steps above and add: `Domain Admins` > **OK**. *(For real admin privileges)*.
