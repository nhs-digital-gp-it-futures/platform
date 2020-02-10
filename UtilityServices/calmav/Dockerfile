# Using the docker image for clamav provided by the Home Office as it is verified and checked to a more rigorous standard than we can possibly hope to achieve in this project
# Source: https://github.com/UKHomeOffice/docker-clamav
FROM quay.io/ukhomeofficedigital/clamav:v1.6.1 
COPY clamd.conf /etc/clamd.conf
RUN cat /etc/clamd.conf