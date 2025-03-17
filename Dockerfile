FROM jenkins/jenkins:lts

# Switch to root user to install dependencies
USER root

# Install required dependencies
RUN apt-get update && apt-get install -y \
    git curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Switch back to Jenkins user
USER jenkins

# Copy plugin list and install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt || \
    (echo "Plugin installation failed, retrying..." && jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt)

# Copy the Jenkins initialization script
COPY seed.groovy /usr/share/jenkins/ref/init.groovy.d/seed.groovy

# Set Jenkins to listen on port 8080
EXPOSE 8080

# Start Jenkins
CMD ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
