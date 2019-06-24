pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                bat 'mvn -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        
            post {
                 success {
                    junit 'target/surefire-reports/*.xml'
                    hygieiaArtifactPublishStep artifactDirectory: 'target', artifactGroup: 'com.addressbook', artifactName: 'addressbook.war', artifactVersion: '2'
                    hygieiaDeployPublishStep applicationName: 'Addressbook', artifactDirectory: 'target', artifactGroup: 'com.addressbook', artifactName: 'addressbook.war', artifactVersion: '2', buildStatus: 'Success', environmentName: 'Dev'
                }
                failure {
                    //junit 'target/surefire-reports/*.xml'
                    hygieiaArtifactPublishStep artifactDirectory: 'target', artifactGroup: 'com.addressbook', artifactName: 'addressbook.war', artifactVersion: '2'
                    hygieiaDeployPublishStep applicationName: 'Addressbook', artifactDirectory: 'target', artifactGroup: 'com.addressbook', artifactName: 'addressbook.war', artifactVersion: '2', buildStatus: 'Failure', environmentName: 'Dev'
                
            }
        }
        
    }
}
