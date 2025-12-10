1. Get the Windows 11 ISO
    1. Go to the Microsoft Evaluation Center 
    2. Download the Windows 11 Enterprise ISO

2. Create the Virtual Machine in VMWare
    1. In VMWare Workstation Pro click File > New Virtual Machine
    2. Select Typical > Select Installer disc image file (ISO) 
    3. Virtual Machine Name: Win11-Client-01
    4. Select "Only the files needed to support a TPM are encrypted". > Password: Password123
    5. Maximum disk size: 64 GB (Windows 11 requires 64 GB so you need to keep this at a minimum)
    6. Leave Memory/CPU at defaults: 4096 MB, CPU cores: 2
    7. Click Finish

3. Install Windows 11
    1. When the VM starts, click inside the black screen and press a key on your keyboard when it says "Press any key to boot from CD or DVD.."
    2. Windows Setup flow: English > Click through until you get to account sign-in
    3. Select Sign-in options > Domain join instead
    4. Who's going to use this device: LocalAdmin, Password: Password123
    5. Complete privacy questions and finish
    6. If you missed device rename, click Settings > System > Rename > Type Client-01

4. Configure Networking
    1. Set DNS
        - On the VM press Windows Key + R > type ncpa.cpl (opens Network Connections)
        - Right click Ethernet0 > Properties
        - Select Internet Protocol Version 4 (TCP/IP) > Properties
        - IP Address: Keep 'Obtain Automatically'
        - DNS Server: 
            - Select 'Use the following DNS server addresses' > Preferred: 192.168.242.10  > Close
    2. Test the DNS
        - From Terminal ping ad.lab - if you get a reply DNS is working

5. Join the Domain
    1. System > About > click Domain or Workgroup
    2. Click Change to Rename this computer of change its domain or workgroup
    3. Click Member of: Domain > Fill in ad.lab > Fill in Username: Administrator and Password
    4. Restart computer

6. Move Client-01 into Workstations OU
    - When the Windows 11 VM joins the domain, Active Directory puts the Client-01 object into the default computers container.
    - However, the login GPO is linked to the Workstations OU. The default computers container is outside the OU so the policy doesn't apply to the VM.
    1. Open Active Directory Users and Computers
    2. Open the Computers container > Drag Client-01 into the Workstations OU, which is inside the DemoCorp_Root OU
    3. On the client open Command Prompt > type `gpupdate /force` > wait for it to say 'Computer policy update has completed successfully'

7. Test the Lab
    - **Test 1: AUP Banner (Computer policy)**
        1. Restart the Windows 11 client VM
        2. Before you type a password, you should see the pop-up: "Security Warning: This system is for authorized use only"
        3. Success: Click OK.
        ![AUP Security Warning Screenshot](./aup-security-warning.png)

    - **Test 2: Control Panel Lockout - (User Policy)**
        1. Log in as: jhr (The Restricted User).
        2. Once logged in, right-click the Start Button and try to open Settings or search for Control Panel.
        - Success: It should show a message: "This operation has been cancelled due to restrictions in effect on this computer."

    - **Test 3: The Admin (Control Check)**
        1. Sign out of jhr.
        2. Sign in as jadmin.
        3. Try to open Settings/Control Panel.
        - Success: It opens normally (because the policy was only applied to the General_Staff OU, not the Admin_Staff OU).
