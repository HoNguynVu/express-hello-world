pipeline {
    agent any

    environment {
        IMAGE_NAME = "express-hello-world"
        IMAGE_TAG = "v${env.BUILD_NUMBER}"
    }

    options {
        timeout(time: 10, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages {
        stage('Checkout Source Code') {
            steps { checkout scm }
        }
        stage('Install dependencies') {
            steps { bat 'yarn install' }
        }
        stage('Security Audit') {
            steps { bat 'yarn audit' }
        }
        stage('Unit Test') {
            steps { bat 'yarn test' }
        }
        stage('Build Docker Image') {
            steps { bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ." }
        }
        stage('Verify Docker Image') {
            steps { bat "docker image inspect ${IMAGE_NAME}:${IMAGE_TAG}" }
        }
    }

    post {
        success {
            echo "✅ [SUCCESS] Pipeline hoàn tất xuất sắc!"
            
            // 1. Gửi Email thông báo thành công
            mail to: 'team-dev@yourcompany.com',
                 subject: "✅ THÀNH CÔNG: Build #${env.BUILD_NUMBER} - ${env.JOB_NAME}",
                 body: "Xin chào team,\n\nPipeline đã chạy thành công. Image mới đã sẵn sàng.\nXem chi tiết tại: ${env.BUILD_URL}"

            // 2. Gửi thông báo qua Slack (Cần cài Slack Notification Plugin)
            // slackSend color: '#36a64f', message: "✅ *THÀNH CÔNG:* Job `${env.JOB_NAME}` build #${env.BUILD_NUMBER}.\nChi tiết: ${env.BUILD_URL}"
        }
        failure {
            echo "❌ [FAILED] Pipeline thất bại!"
            
            // 1. Gửi Email cảnh báo lỗi
            mail to: 'team-dev@yourcompany.com',
                 subject: "❌ THẤT BẠI: Build #${env.BUILD_NUMBER} - ${env.JOB_NAME}",
                 body: "CẢNH BÁO: Pipeline đã gặp lỗi ở một trong các bước (Audit, Test, hoặc Build).\n\nVui lòng kiểm tra log ngay lập tức tại: ${env.BUILD_URL}"

            // 2. Gửi thông báo qua Slack
            // slackSend color: '#ff0000', message: "❌ *THẤT BẠI:* Job `${env.JOB_NAME}` build #${env.BUILD_NUMBER} gặp lỗi!\nVui lòng fix gấp: ${env.BUILD_URL}"
        }
        always {
            echo "🧹 Đang dọn dẹp workspace..."
            cleanWs()
        }
    }
}