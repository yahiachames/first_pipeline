pipeline {
    agent any 
    stages {
        stage('Git Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/yahiachames/first_pipeline'
            }
        }
         stage('Unit Testing'){
            steps{
                sh "mvn test"
            }
        }
           stage('Integration Testing'){
            steps{
                sh "mvn verify -DskipUnitTests"
            }
        }

           stage('Maven Build'){
            steps{
                sh "mvn clean install"
            }
        }
         stage('static code analysis'){
            steps{
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-api-key') {
                            sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
         stage('quality gate'){
            steps{
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api-key'
                }
            }
        }
    }
}