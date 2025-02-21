FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget curl && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y nginx mysql-server php php-fpm php-mysql php-cli && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

# Download AAPanel installer
RUN wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0.23_en.sh && \
    chmod +x install.sh && \
    bash install.sh

# Expose ports
EXPOSE 80 443

# Start the services
CMD ["nginx", "-g", "daemon off;"]
