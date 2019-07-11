pipeline {
    agent any
	environment {
       TOMCAT_HOME = 'C:\\SW\\apache-tomcat-9.0.1\\apache-tomcat-9.0.1'
   }
    stages {
	      stage('UnitTest') {
            steps {
                bat 'mvn test'
            }
        
            } 
       
	    stage('Build') {
            steps {
                bat 'mvn -DskipTests clean package'
            }
             
        }
       
 	
	
    }
    post {
                 success {
                    //junit 'target/surefire-reports/*.xml'
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
