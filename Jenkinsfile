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
                    // Clean up any existing containers
                    bat 'docker-compose down || exit 0'
                    
                    // Start containers
                    bat 'docker-compose up -d'
                    
                    // Wait for containers to start (fixed timeout command)
                    bat 'timeout /t 15 > nul'
                    
                    // Run tests
                    bat 'test.bat'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    // Stop and remove existing container
                    bat 'docker-compose down || exit 0'
                    
                    // Start new container
                    bat 'docker-compose up -d'
                }
            }
        }
    }
    
    post {
        always {
            // Clean up containers (with proper path)
            bat 'cd /d C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\anon && docker-compose down || exit 0'
            
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