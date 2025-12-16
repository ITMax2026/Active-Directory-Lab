Goal: Centralize print management on the Server (DC01) and automate printer mapping for end-users based on their Department/Security Group
 
Deployment Strategy: Group Policy with Item-Level Targeting
  - Instead of creating a seperate GPO for every department (which creates 'GPO Bloat') we use a single GPO with Item-Level Targeting based on Security Groups.
  - This allows the GPO to evaluate 'Is this user in HR?' before mapping the printer
  * Result: Users only see the printes relevant to their job function (Security Group)

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
 Part 1 - Add DC01 to the Print  
  1. Open Print Management (printmanagement.msc)
  2. Right Click Print Servers > Add/Remove Servers
  3. In Add Servers > Write DC01 > Click Add to List

 Part 2 - Create a Fake Port
 1. Expand DC01 > Right click Ports > Add Port...
 2. Select Standard TCP/IT Port > New Port... > Next
 3. Printer Name or IP Address: Pick an address not in use from your subnet
    - My Server is 



 
 5. Expand DC01 > Right click Printers > Add Printer
 6. Select Add a new printer using an existing port
 7. 'Dummy Port' Trick:
    - Select Create a new port > Local Port
    - Enter Port Name: NUL (Deletes the print queue - Often used when print queues are stuck)
  8. Driver: Install a new driver > Manufacturer: Generic > Generic/Text Only
  9. Naming:
     - Printer Name: HR-Printer
     - Share Name: HR-Printer
     - Check: Share this printer
     - Check: List in the directory
    
 Step 3: 
