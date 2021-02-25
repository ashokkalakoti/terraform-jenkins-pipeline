pipeline {
    agent any 
    stages {
        stage("initializing terraform") {
            steps {
                sh "terraform init"
            }
        }
        stage('Vulnerability-Scan - Potential security issues') {
            steps {
                sh "tfsec ."
            }
        }
        stage("planning terraform") {
            steps {
                sh "terraform plan -out myplan"
            }
        }
        stage("Cloud cost estimate") {
            steps {
                sh "terraform show -json myplan > plan.json && infracost --terraform-json-file plan.json"
            }
        }
        stage('Approval') {
           steps {
           script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }
        stage('TF Apply') {
            steps {
           sh "terraform apply -input=false myplan"
        }
    }
  }
}
