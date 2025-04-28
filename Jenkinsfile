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
                    // Cleanup existing containers
                    bat 'docker-compose down || exit 0'
                    
                    // Start containers with healthcheck
                    bat 'docker-compose up -d'
                    
                    // Proper wait command with output suppression
                    bat 'timeout /t 15 > nul'
                    
                    // Run Windows-compatible tests
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
            // Cleanup with absolute path
            bat 'cd /d C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\anon && docker-compose down || exit 0'
            cleanWs()
        }
    }
}