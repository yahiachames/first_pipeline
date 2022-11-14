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
         stage('nexus artifact'){
            steps{
                script {
                    nexusArtifactUploader artifacts: 
                    [[artifactId: 'achat', classifier: '', 
                    file: 'target/achat-1.0-SNAPSHOT.jar', type: 'jar']], credentialsId: 'nexus-auth',
                     groupId: 'tn.esprit.rh', nexusUrl: '127.0.0.1:8081', nexusVersion: 'nexus3',
                      protocol: 'http', repository: 'first_pipeline', version: '1.0'
                }
            }
        }
         stage('build image docker'){
            steps{
                script {
                   sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID'
                   sh 'docker image tag -t $JOB_NAME:v1.$BUILD_ID yahiachames/$JOB_NAME:v1.$BUILD_ID'
                   sh 'docker image tag -t $JOB_NAME:v1.$BUILD_ID yahiachames/$JOB_NAME:latest'
                }
            }
        }
    }
}