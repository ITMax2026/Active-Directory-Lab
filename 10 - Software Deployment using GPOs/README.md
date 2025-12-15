
Goal: Automate the deployment of standard business software (ie Notepad++) to workstations using Group Policy Objects (GPOs)

Deployment Model: Computer-based assignment
  - Computer based assignment is standard for software that should be on every computer.  (There are times where User-based software deployment makes sense, ie, if it's department specific software)

Security Mode:
  - Hidden Share (Deploy$):  The installer sits in a hidden network share; this is mostly done to prevent accidental changes or user browsing confusion
  - Computer-based Permissions:  Unlike standard file shares where Users need access, this software deployment requires Domain Computers to have Read & Execute NTFS permissions
     * The installation have at boot, before users sign on; so the computer must authenticare itself to the server

Of note: GPO Software Installation works best with MSI packages and often there are limitations with EXE-based installers. (EXE files are often deployed with a startup script or the more modern way using Intune)
   
1. Downland Notepad++ MSI
