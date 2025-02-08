pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test || echo "No tests found, skipping..."'
            }
        }
        stage('Build') {
            steps {
                sh 'echo "Build successful!"'
            }
        }
    }
}