pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'ecommerce-web'
        CONTAINER_NAME = 'ecommerce-web-container' 
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE% .'
            }
        }

        stage('Deploy') {
            steps {
                bat '''
                    docker stop %CONTAINER_NAME% || exit 0
                    docker rm %CONTAINER_NAME% || exit 0
                    docker run -d -p 80:80 --name %CONTAINER_NAME% %DOCKER_IMAGE%
                '''
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Static site deployed successfully!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}