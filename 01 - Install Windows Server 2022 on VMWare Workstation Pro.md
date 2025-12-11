## 1. Download and Install VMWare Workstation Pro
1.  Download **VMWare Workstation Pro 25H2** once you have logged in to the **Broadcom** website.
    *   *Note: I installed with Windows Hypervisor Platform.*

## 2. Download Windows Server 2022
1.  Download the **Windows Server 2022 ISO** file from the **Microsoft Evaluation Center**.
    *   *(I chose to use Windows Server 2022 over Windows Server 2025 because it is widely deployed and has more tutorials online).*

## 3. Create a new Virtual Machine
1.  Go to **File** > **New Virtual Machine**.
2.  **Configuration Type:** Select **Typical (recommended)**.
3.  **Guest Operating System Installation:**
    *   Select: **I will install the operating system later**.
    *   *Note: Selecting "Installer disc image file (iso)" here can lead to VMWare 'Easy Install' which asks for a product key on the next screen.*
4.  **Select a Guest Operating System:**
    *   Select **Microsoft Windows** and **Windows Server 2022**.
5.  **Virtual Machine Name:** `Windows Server 2022`
6.  **Specify disk capacity:**
    *   **Maximum disk size:** `60 GB` (Recommended for Windows Server 2022).
    *   Select: **Split virtual disk into multiple files**.
7.  **Ready to Create Virtual Machine:**
    *   *I used the default Memory and CPU settings:*
    *   **Memory:** `2048 MB`
    *   **CPU:** `2` cores

## 4. Attach the ISO Manually
1.  Click on the new **Windows Server 2022** VM > Click **Edit Virtual Machine Settings** at the top.
2.  Select **CD/DVD (SATA)**.
3.  On the right, select **Use ISO image file** > Browse and select the **Windows Server 2022 ISO** file.
4.  Click **OK**.

## 5. Start the Windows Server 2022 VM
1.  Start the VM and make sure to **Press any key to boot from CD/DVD**.
2.  Click **Next** > **Install Now**.
3.  Select **Windows Server 2022 Standard Evaluation (Desktop Experience)**.
4.  **Which type of installation do you want?**
    *   Choose: **Custom: Install Microsoft Server Operating System only (advanced)**.
5.  Select the **60 GB Drive**.
6.  Set your password.

> **✅ Success Criteria:**
> You should now see the **Server Manager > Dashboard**. We will set up Active Directory in the next section.
