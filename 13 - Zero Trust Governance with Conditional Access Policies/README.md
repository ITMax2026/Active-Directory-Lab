Goal: Implement a Zero Trust security model by enforcing Multi-Factor Authentication (MFA) and Geoblocking through Microsoft Entra ID Conditional Access Policies

Deployment Strategy:
  - 'Break Glass' Safety New: Before enforcing restrictions, we establish an emergency, cloud-only administrator account excluded from all policies to prevent accidental tenant lockout
  - Geolocation Authentication:  We define Trusted Locations (the office IP), which reduces MFA fatigue
  - Country Block: If a login originates from a high-risk country, the login is blocked

Purpose: 
  - Identity security: In modern cloud environments, we must verify the identity of the user and the context of the login


