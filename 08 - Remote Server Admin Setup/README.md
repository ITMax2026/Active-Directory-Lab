## **1. Goal & Purpose: RSAT Setup**

**Goal:** Set up RSAT on **Client-01** so that you don't have to either directly log into the **DC01 Server** or RDP into **DC01** for managing Active Directory.

**Purpose:** In a production environment, logging into a Domain Controller (the **DC01 Server**) for daily tasks, like resetting passwords, is a huge security risk. Instead, you set up a secure Admin workstation (**Client-01**) that can modify the Domain Controller with RSAT, as needed.
*We will also use RSAT for future labs in addition to RDP.*

## **2. Installing RSAT on Windows 11 - GUI Method**

1. Go to **Settings** > **System** > **Optional features**.
2. Click **View features**.
3. Click **See Available features** > type **RSAT**.
4. Look for **RSAT: Active Directory Domain Services and Lightweight Directory Services Tools**.
5. Click the box next to it > **Next** > **Install**.

| ✅ **Success Criteria:** RSAT tools should be listed under "Installed features" once the progress bar completes. |
| :--- |

## **3. Testing a Task (Resetting a Password)**

1. Log in using `jadmin`.
2. Launch **Active Directory Users and Computers (ADUC)** on **Client-01**.
3. Press **Windows + R** > type `dsa.msc`.
4. Click on **General Staff** OU.
5. Right-click **John HR** > **Reset Password**.
6. Enter new password: `P@ssword123`.

| ✅ **Success Criteria:** You should receive a confirmation message stating "The password for John HR has been changed." |
| :--- |
