Goal: Centralize print management on the Server (DC01) and automate printer mapping for end-users base on their Department/Security Group
 
  
Deployment Strategy: Group Policy Preferences (GPP) with Item-Level Targeting (ITL)
  - Instead of creating a seperate GPO for every department (which creates 'GPO Bloat') we use a single GPO with Item-Level Targeting.
  - This allows the GPO to evaluate 'Is this user in HR?' before mapping the printer
  * Result: Users only see the printes relevant to their job function

Security Model: Point and Print Restriction
  - Modern Windows security prevents standard users from installing printer drivers (stopping the 'PrintNightmare' exploit)
  - We configure 'Point and Print Restrictions' via GPO to trust the Print Server.  This allows drivers to be installed without granting users Admin access

Purpose:
  - In a production environment, manually installing printers on individual workstations is inefficient.
  - This setup achieves 'Zero-Touch Provisioning':  An HR employee simply logs in, and the correct print drivers and settings are automatically configured


