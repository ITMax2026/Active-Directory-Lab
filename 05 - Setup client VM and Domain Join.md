## 1. Get Windows 11 ISO
1.  Navigate to the **Microsoft Evaluation Center**.
2.  Download the **Windows 11 Enterprise ISO**.

## 2. Create Virtual Machine (VMware)
1.  In VMware Workstation Pro, click **File** > **New Virtual Machine**.
2.  Select **Typical** > **Select Installer disc image file (ISO)**.
3.  **VM Configuration details:**
    *   **Name:** `Win11-Client-01`
    *   **Encryption:** Select "Only the files needed to support a TPM are encrypted."
    *   **Encryption Password:** `Password123`
    *   **Disk Size:** `64 GB` (Windows 11 minimum requirement).
    *   **Hardware:** Leave defaults (4096 MB RAM, 2 CPU Cores).
4.  Click **Finish**.

## 3. Install Windows 11
1.  Start the VM. Click inside the black screen and press any key when prompted to **"boot from CD or DVD."**
2.  **Windows Setup flow:** Select **English** > Click through until you reach account sign-in.
3.  Select **Sign-in options** > **Domain join instead**.
4.  **Local Administrator Setup:**
    *   **User:** `LocalAdmin`
    *   **Password:** `Password123`
5.  Complete privacy questions and finish setup.
6.  *Optional:* If you missed the device rename step during setup, go to **Settings** > **System** > **Rename** and set the name to `Client-01`.

## 4. Configure Networking
### Set DNS
1.  On the VM, press `Windows Key + R` > type `ncpa.cpl` (Opens Network Connections).
2.  Right-click **Ethernet0** > **Properties**.
3.  Select **Internet Protocol Version 4 (TCP/IP)** > **Properties**.
4.  **IP Settings:**
    *   **IP Address:** Keep 'Obtain Automatically'.
    *   **DNS Server:** Select 'Use the following DNS server addresses'.
    *   **Preferred DNS:** `192.168.242.10`
5.  Click **OK** > **Close**.

### Verify Connectivity
Open a Terminal/Command Prompt and run the following command:
```cmd
ping ad.lab
```

> **✅ Success Criteria:**
> You should receive a reply from the Domain Controller. This confirms DNS is resolving correctly.

## 5. Join the Domain
1.  Go to **Settings** > **System** > **About**.
2.  Click **Domain or Workgroup**.
3.  Click **Change** to rename this computer or change its domain.
4.  **Domain Configuration:**
    *   **Member of:** Select **Domain**.
    *   **Domain Name:** `ad.lab`
    *   **Credentials:** Use `Administrator` and your domain admin password.
5.  **Restart** the computer when prompted.

## 6. Move Client-01 to Workstations OU
*Note: When a machine joins the domain, AD places it in the default "Computers" container. GPOs linked to specific OUs (like Workstations) will not apply until the object is moved.*

1.  Log into your Server/Domain Controller.
2.  Open **Active Directory Users and Computers**.
3.  Open the **Computers** container.
4.  Drag `Client-01` into the **Workstations** OU (Located inside `DemoCorp_Root`).
5.  Return to the client machine (Client-01), open Command Prompt, and run:
    ```cmd
    gpupdate /force
    ```

> **✅ Success Criteria:**
> The command prompt should return: *"Computer policy update has completed successfully."*
