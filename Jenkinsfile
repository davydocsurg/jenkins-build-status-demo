pipeline {
    agent any
    triggers {
        githubPush()
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/YOUR_GITHUB_USER/YOUR_REPO.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Add deployment steps here
            }
        }
    }
}
