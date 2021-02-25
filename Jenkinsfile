pipeline {
  agent any
  stages {
    stage('terraform initialize') {
      steps {
        sh 'terraform init'
      }
    }

    stage('terraform plan') {
      steps {
        sh 'terraform plan -out myplan'
      }
    }

    stage('code checker') {
      steps {
        sh 'tfsec .'
      }
    }

    stage('cloud cost estimate') {
      steps {
        sh 'terraform show -json myplan > plan.json && infracost --terraform-json-file plan.json'
      }
    }

    stage('terraform apply') {
      steps {
        script {
          def userInput = input(id: \'confirm\', message: \'Apply Terraform?\', parameters: [ [$class: \'BooleanParameterDefinition\', defaultValue: false, description: \'Apply terraform\', name: \'confirm\'] ])
         }                              
      }
    }

  }
}
