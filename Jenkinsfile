pipeline {
    agent any

    stages {
        stage('Terraform Init') {
            steps {
                dir('/home/ubuntu/terraconfig/') {
                    script {
                        sh 'terraform init'
                    }
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                dir('/home/ubuntu/terraconfig/') {
                    script {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                dir('/home/ubuntu/terraconfig/') {
                    script {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }
}
