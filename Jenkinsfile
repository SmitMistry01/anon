pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'ecommerce-web'
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
                    docker stop %CONTAINER_NAME% || true
                    docker rm %CONTAINER_NAME% || true
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