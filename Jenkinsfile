pipeline {
    agent { label 'master' }
	options { skipDefaultCheckout() }	
    stages {
                    		stage("Checkout SCM") {
						steps {
								cleanWs()
								echo 'checkout scm'
								checkout scm
						}
				}
				stage("Unit Test") {
					agent { label 'windows' }
						steps {
								cleanWs()
								checkout scm
								echo ' Unit Test Stage'
								bat 'mvn test'
								junit 'target\\surefire-reports\\*.xml'	
						}
				}
				stage('Build') {
						steps {
								echo 'Clean Build'
								sh "ls"
								sh "pwd"
								sh "mvn sonar:sonar clean compile -Dtest=\\!TestRunner* -DfailIfNoTests=false -Dsonar.projectKey=addressbook -Dsonar.host.url=http://10.62.125.4:8085/ -Dsonar.login=f16fabd2605044f38e79e4c0e4bc5f73c55dd144"
								//sh "mvn sonar:sonar clean compile -Dtest=\\!TestRunner* -DfailIfNoTests=false -Dsonar.projectKey=employee_jdbc -Dsonar.host.url=http://34.93.123.206/ -Dsonar.login=aac7cc7809ddc82ce0070e3f74726c71216936b6"
								//sh 'mvn clean compile' 
						}
				}
	
				/*stage('Scanning for Security') {
					 steps {
						fodStaticAssessment bsiToken: 'eyJ0ZW5hbnRJZCI6OTY5MywidGVuYW50Q29kZSI6IlZpcnR1c2FfMzQyX0ZNQV8zMjk5MzUyMDYiLCJyZWxlYXNlSWQiOjgwMjIyLCJwYXlsb2FkVHlwZSI6IkFOQUxZU0lTX1BBWUxPQUQiLCJhc3Nlc3NtZW50VHlwZUlkIjoxNCwidGVjaG5vbG9neVR5cGUiOiJKQVZBL0oyRUUiLCJ0ZWNobm9sb2d5VHlwZUlkIjo3LCJ0ZWNobm9sb2d5VmVyc2lvbiI6IjEuNyIsInRlY2hub2xvZ3lWZXJzaW9uSWQiOjEwLCJhdWRpdFByZWZlcmVuY2UiOiJBdXRvbWF0ZWQiLCJhdWRpdFByZWZlcmVuY2VJZCI6MiwiaW5jbHVkZVRoaXJkUGFydHkiOmZhbHNlLCJpbmNsdWRlT3BlblNvdXJjZUFuYWx5c2lzIjpmYWxzZSwicG9ydGFsVXJpIjoiaHR0cHM6Ly90cmlhbC5mb3J0aWZ5LmNvbS8iLCJhcGlVcmkiOiJodHRwczovL2FwaS50cmlhbC5mb3J0aWZ5LmNvbSIsInNjYW5QcmVmZXJlbmNlIjoiU3RhbmRhcmQiLCJzY2FuUHJlZmVyZW5jZUlkIjoxfQ==', entitlementPreference: 'SingleScanOnly', inProgressScanActionType: 'CancelInProgressScan', overrideGlobalConfig: true, personalAccessToken: 'fortifyondemand', remediationScanPreferenceType: 'RemediationScanIfAvailable', srcLocation: '.', tenantId: 'Virtusa_342_FMA_329935206', username: 'preethkumar.k@gmail.com'
						fodPollResults bsiToken: 'eyJ0ZW5hbnRJZCI6OTY5MywidGVuYW50Q29kZSI6IlZpcnR1c2FfMzQyX0ZNQV8zMjk5MzUyMDYiLCJyZWxlYXNlSWQiOjgwMjIyLCJwYXlsb2FkVHlwZSI6IkFOQUxZU0lTX1BBWUxPQUQiLCJhc3Nlc3NtZW50VHlwZUlkIjoxNCwidGVjaG5vbG9neVR5cGUiOiJKQVZBL0oyRUUiLCJ0ZWNobm9sb2d5VHlwZUlkIjo3LCJ0ZWNobm9sb2d5VmVyc2lvbiI6IjEuNyIsInRlY2hub2xvZ3lWZXJzaW9uSWQiOjEwLCJhdWRpdFByZWZlcmVuY2UiOiJBdXRvbWF0ZWQiLCJhdWRpdFByZWZlcmVuY2VJZCI6MiwiaW5jbHVkZVRoaXJkUGFydHkiOmZhbHNlLCJpbmNsdWRlT3BlblNvdXJjZUFuYWx5c2lzIjpmYWxzZSwicG9ydGFsVXJpIjoiaHR0cHM6Ly90cmlhbC5mb3J0aWZ5LmNvbS8iLCJhcGlVcmkiOiJodHRwczovL2FwaS50cmlhbC5mb3J0aWZ5LmNvbSIsInNjYW5QcmVmZXJlbmNlIjoiU3RhbmRhcmQiLCJzY2FuUHJlZmVyZW5jZUlkIjoxfQ==', overrideGlobalConfig: true, personalAccessToken: 'fortifyondemand', pollingInterval: 1, tenantId: 'Virtusa_342_FMA_329935206', username: 'preethkumar.k@gmail.com'
					}
				}*/  
	    
	    
	    			stage('Scanning for Security') {
					 steps {
						fodStaticAssessment bsiToken: 'eyJ0ZW5hbnRJZCI6OTc2NSwidGVuYW50Q29kZSI6IlRyaW1ibGVfMzRfRk1BXzMwNTI1OTMzNCIsInJlbGVhc2VJZCI6ODA3ODMsInBheWxvYWRUeXBlIjoiQU5BTFlTSVNfUEFZTE9BRCIsImFzc2Vzc21lbnRUeXBlSWQiOjE0LCJ0ZWNobm9sb2d5VHlwZSI6IkpBVkEvSjJFRSIsInRlY2hub2xvZ3lUeXBlSWQiOjcsInRlY2hub2xvZ3lWZXJzaW9uIjoiMS43IiwidGVjaG5vbG9neVZlcnNpb25JZCI6MTAsImF1ZGl0UHJlZmVyZW5jZSI6IkF1dG9tYXRlZCIsImF1ZGl0UHJlZmVyZW5jZUlkIjoyLCJpbmNsdWRlVGhpcmRQYXJ0eSI6ZmFsc2UsImluY2x1ZGVPcGVuU291cmNlQW5hbHlzaXMiOmZhbHNlLCJwb3J0YWxVcmkiOiJodHRwczovL3RyaWFsLmZvcnRpZnkuY29tLyIsImFwaVVyaSI6Imh0dHBzOi8vYXBpLnRyaWFsLmZvcnRpZnkuY29tIiwic2NhblByZWZlcmVuY2UiOiJTdGFuZGFyZCIsInNjYW5QcmVmZXJlbmNlSWQiOjF9', entitlementPreference: 'SingleScanOnly', inProgressScanActionType: 'CancelInProgressScan', overrideGlobalConfig: true, personalAccessToken: 'fortifyondemand', remediationScanPreferenceType: 'RemediationScanIfAvailable', srcLocation: '.', tenantId: 'Trimble_34_FMA_305259334', username: 'fortifytest1724@gmail.com'
						fodPollResults bsiToken: 'eyJ0ZW5hbnRJZCI6OTc2NSwidGVuYW50Q29kZSI6IlRyaW1ibGVfMzRfRk1BXzMwNTI1OTMzNCIsInJlbGVhc2VJZCI6ODA3ODMsInBheWxvYWRUeXBlIjoiQU5BTFlTSVNfUEFZTE9BRCIsImFzc2Vzc21lbnRUeXBlSWQiOjE0LCJ0ZWNobm9sb2d5VHlwZSI6IkpBVkEvSjJFRSIsInRlY2hub2xvZ3lUeXBlSWQiOjcsInRlY2hub2xvZ3lWZXJzaW9uIjoiMS43IiwidGVjaG5vbG9neVZlcnNpb25JZCI6MTAsImF1ZGl0UHJlZmVyZW5jZSI6IkF1dG9tYXRlZCIsImF1ZGl0UHJlZmVyZW5jZUlkIjoyLCJpbmNsdWRlVGhpcmRQYXJ0eSI6ZmFsc2UsImluY2x1ZGVPcGVuU291cmNlQW5hbHlzaXMiOmZhbHNlLCJwb3J0YWxVcmkiOiJodHRwczovL3RyaWFsLmZvcnRpZnkuY29tLyIsImFwaVVyaSI6Imh0dHBzOi8vYXBpLnRyaWFsLmZvcnRpZnkuY29tIiwic2NhblByZWZlcmVuY2UiOiJTdGFuZGFyZCIsInNjYW5QcmVmZXJlbmNlSWQiOjF9', overrideGlobalConfig: true, personalAccessToken: 'fortifyondemand', pollingInterval: 1, tenantId: 'Trimble_34_FMA_305259334', username: 'fortifytest1724@gmail.com'
					}
				}
	
				stage('Package') {
					steps {
						echo 'Packaging'
						sh 'mvn package -DskipTests'
					}
				}   
	    			stage("XLDeploy Package") {
					steps {
						xldCreatePackage artifactsPath: 'target', manifestPath: 'deployit-manifest.xml', darPath: '$JOB_NAME-$BUILD_NUMBER.0.dar'  
					}
				}
	    			stage('XLDeploy Publish') {  
					steps {
    						xldPublishPackage serverCredentials: 'XLDeployServer', darPath: '$JOB_NAME-$BUILD_NUMBER.0.dar'
					}
				}  
	    			stage('XLDeploy Deploy') { 
					steps {
    						xldDeploy serverCredentials: 'XLDeployServer', environmentId: 'Environments/QATomcatENv', packageId: 'Applications/PetClinic-war/$BUILD_NUMBER.0'
					}
				}  
				
	}
    tools {
        maven 'maven3.3.9'
        jdk 'openjdk8'
    }
    environment {
        // This can be nexus3 or nexus2
        NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running
        NEXUS_URL = "10.62.125.4:8084"
        //NEXUS_URL = "35.200.184.59:8081"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "maven-snapshots"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexusadmin"
    }
    
    post {
         always {
            echo 'JENKINS PIPELINE'

        }
        success {
            echo 'JENKINS PIPELINE SUCCESSFUL'
        }
        failure {
            echo 'JENKINS PIPELINE FAILED'
        }
        unstable {
            echo 'JENKINS PIPELINE WAS MARKED AS UNSTABLE'
        }
        changed {
            echo 'JENKINS PIPELINE STATUS HAS CHANGED SINCE LAST EXECUTION'
        }
    }
}
