FROM centos:7

# Install dependencies and setup environment
RUN yum update -y && \
    yum install -y wget curl sudo which && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install aaPanel
RUN wget -O install.sh https://download.aapanel.com/script/install_6.0_en.sh && \
    bash install.sh aapanel

# Expose essential ports
# 7800 - aaPanel Web Interface
# 80/443 - HTTP/HTTPS
# 21 - FTP
# 22 - SSH
# 8888 - phpMyAdmin
EXPOSE 7800 80 443 21 22 8888

# Start aaPanel services and keep container running
CMD /etc/init.d/bt start && tail -f /dev/null
