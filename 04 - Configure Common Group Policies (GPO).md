**Prerequisite:** Open **Group Policy Management** (**Server Manager** > **Tools**).
Expand **Forest: ad.lab** > **Domains** > **ad.lab** > **DemoCorp_Root**.

## GPO #1: Acceptable Use Policy Banner (Computer Policy)
*Concept: This applies to the computer, regardless of who logs in. The Computer object must be inside the Workstations OU.*

1.  Right-click the **Workstations** OU (inside of `DemoCorp_Root`) and select **Create a GPO in this domain, and Link it here...**
2.  Name it: `PC_Workstation_AUP`
3.  Right-click the new policy and select **Edit**.
4.  Navigate to: **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.
5.  Edit these two settings:
    *   **Interactive logon: Message title for users attempting to log on.**
        *   Set this to: `Security Warning`
    *   **Interactive logon: Message text for users attempting to log on.**
        *   Set this to: `This system is for authorized use only. Users must obey the Acceptable Use Policy`
6.  Click **OK** and close the editor.

## GPO #2: Control Panel Lockout (User Policy)
*Concept: This applies to the users (Staff), regardless of which computer they use. This will affect John and Jeff differently.*

1.  Right-click the **General_Staff** OU > **Create a GPO in this domain, and Link it here...**
2.  Name: `U_Staff_Restrict_ControlPanel`
3.  Right-click the new policy and select **Edit**.
4.  Navigate to: **User Configuration** > **Policies** > **Administrative Templates** > **Control Panel**.
5.  Double-click **Prohibit access to Control Panel and PC Settings**.
6.  Select **Enabled** towards the top > Select **Apply** > **OK**.
    *   *Verification: On the policy in the folder, you should see the label switch from "Not Configured" to "Enabled".*

## Next Steps
*You have staged two GPOs, but for Part 5 (Testing) to work, you must remember GPO Application Rules:*

> **⚠️ Important GPO Rules:**
>
> *   **New User Rule:** Since `jhr` is inside the `General_Staff` OU, the Control Panel block will apply to him immediately.
> *   **New Computer Rule:** When you join a Client VM in the next step, it will default to the generic "Computers" folder. You will have to drag the object into your **Workstations** OU for the policy to apply.
