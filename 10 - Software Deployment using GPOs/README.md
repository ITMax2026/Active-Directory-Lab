
Goal: Automate the deployment of standard business software (ie Notepad++) to workstations using Group Policy Objects (GPOs)

Deployment Model: Computer-based assignment
  - Computer based assignment is standard for software that should be on every computer.  (There are times where User-based software deployment makes sense, ie, if it's department specific software)

Security Mode:
  - Hidden Share (Deploy$):  The installer sits in a hidden network share; this is mostly done to prevent accidental changes or user browsing confusion
  - Computer-based Permissions:  Unlike standard file shares where Users need access, this software deployment requires Domain Computers to have Read & Execute NTFS permissions
     * The installation have at boot, before users sign on; so the computer must authenticare itself to the server

Of note: GPO Software Installation works best with MSI packages and often there are limitations with EXE-based installers. (EXE files are often deployed with a startup script or the more modern way using Intune)

1. Create the 'Deploy$' Share on DC (Server)
  1. Create the folder
     - On the server (C: drive) create a new folder named Deploy
  2. Share Permissions: Network Access
      - Right Deploy > Properties > Sharing > Advanced Sharing
      - Check Share this folder
      - Share Name: Change to Deploy$ ($ makes it hidden, as discussed above)
      - Click Permissions. Remove Everyone.  Add Authenticated Users (Read).  Click ok
  3. NTFS Permissions: Computer permissions
      - Click the Security tab
      - Click Edit > Add
      - Click Object Types > Check Computers > Click OK
      - Type Domain Computers > Check Names > Select Domain Computers > OK
      - Ensure Domain Computers has Read & Execute allowed > Click OK > Close
   
2. Downland on Client: Notepad++ MSI
  1. Go to offical Notepad++ Downloads page > Select latest release > Download the 64-bit installer
  2. Make sure to click the MSI - Installer
  3. On the Client: Open File Explorer and type into the top address bar"
    - \\DC01\c$
  4. This will open the C: folder on the Server.  Open the Deploy folder you just created
  5. Drag and drop the MSI file from the Clients downloads folder to the Deploy folder

3. Organize Active Directory
  1. Open Active Directory Users and Computers (ADUC)
  2. 


    
