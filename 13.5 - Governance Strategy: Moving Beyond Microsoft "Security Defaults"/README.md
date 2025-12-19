This is a unique section.  This is an unplanned section and something I'm only writing after the fact. 

The Goal:  Make users aware of the conflicts that will arise with Microsoft default security setting, why they are in place and how to manage this issue.

1. The Operational Challenge:
  - As we moved into Part 13 (Zero Trust Governance), we encountered an unexpected architectural conflict.
  - The goal was to implement a "Smart" security posture, requiring MFA for most access but relaxing it for Trusted Locations (e.g., the secure home lab network).
  - However, we found that our attempts to customize these rules were being conflicted by Microsoft’s pre-configured "Security Defaults" and Microsoft-managed Conditional Access policies
  - Later, we realized this rigidity would also impact Part 15 (Intune), where these same default policies would block devices from silently enrolling in management.

2. 
