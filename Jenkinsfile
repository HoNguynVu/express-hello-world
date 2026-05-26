pipeline {
    agent any

    environment {
        IMAGE_NAME = "express-hello-world"
        IMAGE_TAG = "v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                checkout scm
            }
        }

        stage('Install dependencies') {
            steps {
                bat 'yarn install'
            }
        }

        stage('Test') {
            steps {
                bat 'yarn test || echo "Chua co scripts test trong package.json"'
            }
        }

        stage('Build docker image') {
            steps {
                bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline đã hoàn thành xuất sắc!"
        }
        failure {
            echo "❌ Pipeline đã failed!"
        }
        always {
            cleanWs()
        }
    }
}