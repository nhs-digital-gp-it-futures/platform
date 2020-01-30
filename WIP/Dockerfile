# Base Image
FROM microsoft/vsts-agent:ubuntu-16.04-docker-18.06.1-ce-standard

# Import the public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Ubuntu repository
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list

# Insntall NPM Package
RUN sudo npm install -g eslint @vue/cli @vue/eslint-config-standard

# Download the GNU Privacy Guard (GnuPG or GPG) keys
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
 
# Register the GPG keys from the Microsoft repository
RUN sudo dpkg -i packages-microsoft-prod.deb
 
# Routine update of packages
RUN sudo apt-get update
 
# Now, enable the "universe" repos
RUN sudo add-apt-repository universe
 
# Install PowerShell
RUN sudo apt-get install -y powershell