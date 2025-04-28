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
                    // Start the container for testing
                    sh 'docker-compose up -d'
                    
                    // Make the test script executable
                    sh 'chmod +x test.sh'
                    
                    // Run the test
                    sh './test.sh'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    // Stop and remove existing container if running
                    sh 'docker-compose down || true'
                    
                    // Start the new container
                    sh 'docker-compose up -d'
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