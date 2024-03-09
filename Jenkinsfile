pipeline {
    agent any
    
    environment {
        TF_WORKSPACE = '/home/ubuntu/terraconfig' 
    }

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    sh "cd ${env.TF_WORKSPACE} && terraform init"
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    sh "cd ${env.TF_WORKSPACE} && terraform plan -out=tfplan"
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh "cd ${env.TF_WORKSPACE} && terraform apply -auto-approve tfplan"
                }
            }
        }

    }

   
}
