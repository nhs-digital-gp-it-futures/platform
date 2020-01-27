# Base Image
FROM microsoft/vsts-agent:ubuntu-16.04-standard

# Import the public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Ubuntu repository
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list

# Install PowerShell
RUN sudo apt-get install -y powershell

# Insntall NPM Package
RUN sudo npm install -g eslint @vue/cli @vue/eslint-config-standard

# Insntall .Net sdk
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o microsoft.asc.gpg
RUN sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/prod.list
RUN sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
RUN sudo apt-get install -y apt-transport-https
RUN sudo apt-get update
RUN sudo apt-get install dotnet-runtime-3.1