Objective: 
  - Transition device management from legacy on-premise Group Policy (GPO) to Microsoft Intune.  
  - Show that security policies and software could be successfully deployed to a Hybrid-joined device over the open internet

Purpose:
  - As organizations shift more towards remote and hybrid work, relying on local Domain Controllers for policy configuration is no longer suitable

Why Intune is winning over Active Directory GPO:
  - In an on-prem environment a computer had to be on the office Wi-Fi or a VPN to get a GPO update 
  - If a user stayed home for a month, their computer became unmanaged and unpatched


Technical Strategy:
  1. Device Hardening: Use Intune Settings to create a 'Modern GPO' that restricts disables the camera (security compliance)
  2. Automated Provisioning (App Deployment): Utilizing the Microsoft Store (new), install software (Microsoft Connect) without user intervention or local deployment

Part 1: Modern GPO
  1. Intune Admin Center > Devices > Configuration > Create > New Policy
  2. Platform: Windows 10 and later
  3. Profile Type: Settings Catalog
  4. Name: Win - Security - Block Camera
  5. Configuration Settings:
     - Add Setting > Settings Picker > Seacrch for Camera > Select
     - Check the box for Allow Camera
     - Allow Canera - Set the toggle to Not Allowed
  6. Assignments:
     - Select Add Groups > Click Lab Devices

Part 2: Cloud Install (Company Portal)
  1. Intune Admin Center > Apps > Windows > Create
  2. App Type: Windows Store app (new) > Select
  3. Search: Company Portal > Select
  4. Assignments:
     - Required: Lab Devices Group
     - Next > Create
  6. 
     
