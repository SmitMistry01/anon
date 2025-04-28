pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'ecommerce-web'
        DOCKER_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    // Clean up existing containers
                    bat 'docker-compose down || exit 0'
                    
                    // Start new containers
                    bat 'docker-compose up -d'
                    
                    // Fixed wait command - removed input redirection
                    bat 'timeout /t 15 > nul'
                    
                    // Run tests
                    bat 'test.bat'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    bat 'docker-compose down || exit 0'
                    bat 'docker-compose up -d'
                }
            }
        }
    }
    
    post {
        always {
            // Cleanup with proper path
            bat 'cd /d C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\anon && docker-compose down || exit 0'
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}