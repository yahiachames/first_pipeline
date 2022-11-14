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
    }
}