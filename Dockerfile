FROM jenkins/jenkins:lts

# Switch to root user to install system-level dependencies
USER root

# Install required dependencies (git, curl, unzip + Node.js)
RUN apt-get update && \
    apt-get install -y git curl unzip && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm && \
    rm -rf /var/lib/apt/lists/*

# (Optional) Verify Node.js installation
RUN node -v && npm -v

# Switch back to Jenkins user
USER jenkins

# Copy plugin list and install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt || \
    (echo "Plugin installation failed, retrying..." && jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt)

# Copy the Jenkins initialization script
COPY seed.groovy /usr/share/jenkins/ref/init.groovy.d/seed.groovy

# Expose Jenkins web interface
EXPOSE 8080

# Start Jenkins
CMD ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
