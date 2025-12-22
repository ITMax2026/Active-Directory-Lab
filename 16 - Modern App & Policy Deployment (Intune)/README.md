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

