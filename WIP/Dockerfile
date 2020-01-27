# Base Image
FROM ubuntu-16.04-standard

# Import the public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Ubuntu repository
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list

# Install PowerShell
RUN sudo apt-get install -y powershell

# Insntall NPM Package
RUN sudo npm install -g eslint @vue/cli @vue/eslint-config-standard