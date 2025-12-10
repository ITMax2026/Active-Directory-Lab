1. Test the Lab
    - **Test 1: AUP Banner (Computer policy)**
        1. Restart the Windows 11 client VM
        2. Before you type a password, you should see the pop-up: "Security Warning: This system is for authorized use only"
     
           ![AUP Security Warning Screenshot](images/05-aup-security-warning.png)

        3. Success: Click OK.

    - **Test 2: Control Panel Lockout - (User Policy)**
        1. Log in as: jhr (The Restricted User).
        2. Once logged in, right-click the Start Button and try to open Settings or search for Control Panel.
        - Success: It should show a message: "This operation has been cancelled due to restrictions in effect on this computer."

    - **Test 3: The Admin (Control Check)**
        1. Sign out of jhr.
        2. Sign in as jadmin.
        3. Try to open Settings/Control Panel.
        - Success: It opens normally (because the policy was only applied to the General_Staff OU, not the Admin_Staff OU).
