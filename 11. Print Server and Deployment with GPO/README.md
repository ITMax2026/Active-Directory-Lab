Goal: Centralize print management on the Server (DC01) and automate printer mapping for end-users base on their Department/Security Group
 
  
Deployment Strategy: Group Policy Preferences (GPP) with Item-Level Targeting (ITL)
  - Instead of creating a seperate GPO for every department (which creates 'GPO Bloat') we use a single GPO with Item-Level Targeting.
  - This allows the GPO to evaluate 'Is this user in HR?' before mapping the printer
  * Result: Users only see the printes relevant to their job function



Purpose:
  - In a production environment, manually installing printers on individual workstations is inefficient.
  - This setup achieves 'Zero-Touch Provisioning':  An HR employee simply logs in, and the correct print drivers and settings are automatically configured


Step 1: Install the Print Server Role - On the Server
 1. Open Server Manager > Manage > Add Roles and Features
 2. Click through the wizard, making sure DC01 is selected
 3. At Server Roles > Select Print and Documet Services
 4. Click through the wizard > At Role Services make sure Print Server is selected
 5. Install

Step 2: Driver Setup and Printer Creation - On the Client
 1. Open Print Management (printmanagement.msc)
 2. Right Click Print Servers > Add/Remove Servers
 3. In Add Servers > Write DC01 > Click Add to List
 4. Expand DC01 > Right click Printers > Add Printer
 5. Select Add a new printer using an existing port
 6. 'Dummy Port' Trick: (Also often used to clear stuck print queues)
    - Select Create a new port > Local Port
    - Enter Port Name: NUL (Deletes the data so queues won't get stuck)
  7. Driver: Install a new driver > Manufacturer: Generic > Generic/Text Only
  8. Naming:
     - Printer Name: HR-Printer
     - Share Name: HR-Printer
     - Check: Share this printer
     - Check: List in the directory
    
 Step 3: 
