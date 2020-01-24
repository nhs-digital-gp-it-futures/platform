# Base Image
FROM microsoft/vsts-agent:ubuntu-16.04-docker-18.06.1-ce-standard

# Install Terraform
RUN curl -O https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip \
  && unzip terraform_0.11.7_linux_amd64.zip -d /usr/local/bin/ \
  && export PATH="$PATH:/usr/local/bin"

# Import the public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Ubuntu repository
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list

# Install PowerShell
RUN sudo apt-get install -y powershell

# Insntall NPM Package
RUN sudo npm install -g eslint @vue/cli @vue/eslint-config-standard

# Set env variables
ENV VSTS_AGENT='$(hostname)-agent'
ENV VSTS_WORK='/var/vsts/$VSTS_AGENT'

CMD ["./start.sh"]