pipeline {
    agent any
	environment {
       TOMCAT_HOME = 'C:\\SW\\apache-tomcat-9.0.1\\apache-tomcat-9.0.1'
   }
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
        
           
        }  
 	stage('Deploy'){
		steps{
		
			bat 'COPY "target\\addressbook.war" "C:\\SW\\apache-tomcat-9.0.1\\apache-tomcat-9.0.1\\webapps\\addressbook.war"'
		}
	}
	 stage('Inegration Test'){
		    steps{
		    git branch: 'QA', url: 'https://github.com/IATVirtusa/devops.git'
		    bat 'mvn test'
		    }
	 }
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
