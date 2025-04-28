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
                    // Start the container for testing (Windows version)
                    bat 'docker-compose up -d'
                    
                    // Make the test script executable (only needed on Linux)
                    // bat 'call test.bat'  // Use this if you have a Windows batch test script
                    
                    // Run the test (Windows version)
                    bat 'test.bat'  // You should create a test.bat file for Windows
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    // Stop and remove existing container if running (Windows version)
                    bat 'docker-compose down || exit 0'
                    
                    // Start the new container (Windows version)
                    bat 'docker-compose up -d'
                }
            }
        }
    }
    
    post {
        always {
            // Clean up workspace
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