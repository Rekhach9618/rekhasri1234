pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Rekhach9618/rekhasri1234.git' // Replace with your repo
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                input 'Approve Terraform Apply?' // Manual approval step
                sh 'terraform apply -auto-approve'
            }
        }
    }
    post {
        success {
            echo 'Infrastructure provisioned successfully!'
        }
        failure {
            echo 'Infrastructure provisioning failed!'
        }
    }
}
