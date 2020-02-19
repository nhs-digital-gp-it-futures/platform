# Local Kubernetes Development Environment

This folder contains the scripts necessary to run the entire environment locally. 

To run the system, you need to create a secret to access the private container registry.

Then, run `launch-environment{.sh|ps1}` to launch the environment.
The script will start:
- Document Service
  - DAPI on port 
  - Azurite on ports
- Buying Catalogue Service
  - BAPI on port
  - 


Run `tear-down-environment{.sh|ps1}` to tear down the environment.

