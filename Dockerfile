FROM centos:7

# Set up an alternative repository to avoid issues with the default repositories
RUN sed -i 's|mirrorlist=|#mirrorlist=|' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|' /etc/yum.repos.d/CentOS-Base.repo

# Install dependencies and setup environment
RUN yum update -y && \
    yum install -y wget curl sudo which && \
    yum clean all && \
    rm -rf /var/cache/yum

# Test internet connectivity
RUN ping -c 4 google.com

# Install aaPanel
RUN wget -O install.sh https://download.aapanel.com/script/install_6.0_en.sh || \
    { echo "Failed to download aaPanel installation script"; exit 1; } && \
    bash install.sh aapanel

# Expose essential ports
# 7800 - aaPanel Web Interface
# 80/443 - HTTP/HTTPS
# 21 - FTP
# 22 - SSH
# 8888 - phpMyAdmin
EXPOSE 7800 80 443 21 22 8888

# Start aaPanel services and keep container running
CMD ["/bin/bash", "-c", "/etc/init.d/bt start && tail -f /dev/null"]
