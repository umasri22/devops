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
				echo 'Unit Test Stage'
				bat 'mvn test'
				junit 'target\\surefire-reports\\*.xml'	
				
			}
		}
		/*stage('Scanning for Security') {
			steps {
				echo 'Code Vulnerability Scan'	
				//fodStaticAssessment bsiToken: 'eyJ0ZW5hbnRJZCI6MTAwODYsInRlbmFudENvZGUiOiJUZWNoX01haGluZHJhXzEwNTNfRk1BXzY0NzA3Mzc4NSIsInJlbGVhc2VJZCI6ODUxNDQsInBheWxvYWRUeXBlIjoiQU5BTFlTSVNfUEFZTE9BRCIsImFzc2Vzc21lbnRUeXBlSWQiOjE0LCJ0ZWNobm9sb2d5VHlwZSI6IkpBVkEvSjJFRSIsInRlY2hub2xvZ3lUeXBlSWQiOjcsInRlY2hub2xvZ3lWZXJzaW9uIjoiMS44IiwidGVjaG5vbG9neVZlcnNpb25JZCI6MTIsImF1ZGl0UHJlZmVyZW5jZSI6IkF1dG9tYXRlZCIsImF1ZGl0UHJlZmVyZW5jZUlkIjoyLCJpbmNsdWRlVGhpcmRQYXJ0eSI6ZmFsc2UsImluY2x1ZGVPcGVuU291cmNlQW5hbHlzaXMiOmZhbHNlLCJwb3J0YWxVcmkiOiJodHRwczovL3RyaWFsLmZvcnRpZnkuY29tLyIsImFwaVVyaSI6Imh0dHBzOi8vYXBpLnRyaWFsLmZvcnRpZnkuY29tIiwic2NhblByZWZlcmVuY2UiOiJTdGFuZGFyZCIsInNjYW5QcmVmZXJlbmNlSWQiOjF9', entitlementPreference: 'SingleScanOnly', inProgressScanActionType: 'CancelInProgressScan', overrideGlobalConfig: true, personalAccessToken: 'fortifyondemand', remediationScanPreferenceType: 'RemediationScanIfAvailable', srcLocation: '.', tenantId: 'Tech_Mahindra_1053_FMA_647073785', username: 'vinoth_b.e@rediffmail.com'
				//fodPollResults bsiToken: 'eyJ0ZW5hbnRJZCI6MTAwODYsInRlbmFudENvZGUiOiJUZWNoX01haGluZHJhXzEwNTNfRk1BXzY0NzA3Mzc4NSIsInJlbGVhc2VJZCI6ODUxNDQsInBheWxvYWRUeXBlIjoiQU5BTFlTSVNfUEFZTE9BRCIsImFzc2Vzc21lbnRUeXBlSWQiOjE0LCJ0ZWNobm9sb2d5VHlwZSI6IkpBVkEvSjJFRSIsInRlY2hub2xvZ3lUeXBlSWQiOjcsInRlY2hub2xvZ3lWZXJzaW9uIjoiMS44IiwidGVjaG5vbG9neVZlcnNpb25JZCI6MTIsImF1ZGl0UHJlZmVyZW5jZSI6IkF1dG9tYXRlZCIsImF1ZGl0UHJlZmVyZW5jZUlkIjoyLCJpbmNsdWRlVGhpcmRQYXJ0eSI6ZmFsc2UsImluY2x1ZGVPcGVuU291cmNlQW5hbHlzaXMiOmZhbHNlLCJwb3J0YWxVcmkiOiJodHRwczovL3RyaWFsLmZvcnRpZnkuY29tLyIsImFwaVVyaSI6Imh0dHBzOi8vYXBpLnRyaWFsLmZvcnRpZnkuY29tIiwic2NhblByZWZlcmVuY2UiOiJTdGFuZGFyZCIsInNjYW5QcmVmZXJlbmNlSWQiOjF9', overrideGlobalConfig: true, personalAccessToken: 'fortifyondemand', pollingInterval: 1, tenantId: 'Tech_Mahindra_1053_FMA_647073785', username: 'vinoth_b.e@rediffmail.com'				
			}
		} */			
		stage('Build and Package (with code quality check)') {
			steps {
				echo 'Clean Build'
				sh "ls"
				sh "pwd"
				sh "mvn sonar:sonar clean compile package -Dtest=\\!TestRunner* -DfailIfNoTests=false -Dsonar.projectKey=addressbook -Dsonar.host.url=http://10.62.125.9:8085/ -Dsonar.login=f16fabd2605044f38e79e4c0e4bc5f73c55dd144" 
			}
		}
		
		/*stage('Spin new Developer QA Environment with Tomcat 8') {
			agent { label 'windows' }
			steps {
				//bat 'E:'
				//bat 'cd E:\\\\VagrantBoxes\\testvagrant'
				bat 'vagrant up'
			}
		}
		
		stage("Regression test in Developer QA env - dummy") {
			steps {
				sh 'sleep 30'	
			}
		}
		
		stage('Decommision the Developer QA Environment') {
			agent { label 'windows' }
			steps {
				bat 'vagrant destroy -f'
			}
		}*/

		stage("XLDeploy Package") {
			steps {
				sh "sed -i 's/{{PACKAGE_VERSION}}/$BUILD_NUMBER.0/g' deployit-manifest.xml"
				xldCreatePackage artifactsPath: 'target', manifestPath: 'deployit-manifest.xml', darPath: '$JOB_NAME-$BUILD_NUMBER.0.dar'  
			}
		}
	    
		stage('XLDeploy Publish') {  
			steps {
				xldPublishPackage serverCredentials: 'XLDeployServer', darPath: '$JOB_NAME-$BUILD_NUMBER.0.dar'
			}
		}  
	    
		stage('XLDeploy Deploy - Promote to QA') { 
			steps {
				xldDeploy serverCredentials: 'XLDeployServer', environmentId: 'Environments/QATomcatEnv', packageId: 'Applications/AddressBook/$BUILD_NUMBER.0'
			}
		}
				
		stage("Test Repo checkout") {
			agent { label 'windows' }
			steps {
				echo 'checkout web BDD' 
				checkout([  
					$class: 'GitSCM', 
					branches: [[name: 'refs/heads/master']], 
					doGenerateSubmoduleConfigurations: false, 
					extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'web']], 
					submoduleCfg: [], 
					userRemoteConfigs: [[credentialsId: 'rakeshgitvirtusatoken1', url: 'https://git.virtusa.com/intelligent-automation/Addressbook_web_test.git']]
				])
				echo 'checkout API BDD'
				checkout([  
					$class: 'GitSCM', 
					branches: [[name: 'refs/heads/master']], 
					doGenerateSubmoduleConfigurations: false, 
					extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'api']], 
					submoduleCfg: [], 
					userRemoteConfigs: [[credentialsId: 'rakeshgitvirtusatoken1', url: 'https://git.virtusa.com/intelligent-automation/ProductList_api_test.git']]
				])
				echo 'checkout Swing Desktop'
				checkout([  
					$class: 'GitSCM', 
					branches: [[name: 'refs/heads/master']], 
					doGenerateSubmoduleConfigurations: false, 
					extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'swing']], 
					submoduleCfg: [], 
					userRemoteConfigs: [[credentialsId: 'rakeshgitvirtusatoken1', url: 'https://git.virtusa.com/intelligent-automation/Feedback_swing_test.git']]
				])		
				echo "checkout api performance"
				checkout([  
					$class: 'GitSCM', 
					branches: [[name: 'refs/heads/master']], 
					doGenerateSubmoduleConfigurations: false, 
					extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'api_performance']], 
					submoduleCfg: [], 
					userRemoteConfigs: [[credentialsId: 'rakeshgitvirtusatoken1', url: 'https://git.virtusa.com/intelligent-automation/API_Performance.git']]
				])
					
			} 
		}
		stage("API Smoke Test") {
			agent { label 'windows' }
			steps {
				dir('api') {
					echo 'API smoke Testing Stage'
					step([$class: 'XrayExportBuilder', filePath: '\\src\\test\\java\\com\\virtusa\\qa\\api', issues: 'API-5', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
					catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
						bat 'mvn clean test -Dcucumber.options="--tags @smoke"'
					}					
					bat 'mkdir ..\\target\\cucumber-reports\\API-Smoke'
					bat 'copy target\\surefire-reports\\com.virtusa.qa.api.product.json ..\\target\\cucumber-reports\\API-Smoke\\API-smoke.json'
					step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart',importInfo:'''{
						"fields": {
							"project": {
								"id": "10100"
							},
							"summary": "Smoke Api Test Execution for BDD (Generated By API Product ${BUILD_NUMBER})",
							"issuetype": {
								"id": "10007"
							},
					   "labels":["smoke","Jenkins","Api"],
							"customfield_10032" : [
							   "Dev"
							]
						}
					}''',inputInfoSwitcher:"fileContent",importFilePath: '\\target\\surefire-reports\\com.virtusa.qa.api.1_API-1.json', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
				}
			}
		}
		stage("Web Smoke Test") {
			agent { label 'windows' }
			steps {
				dir('web') {
					echo 'WEB BDD Testing Stage'
					step([$class: 'XrayExportBuilder', filePath: '\\src\\test\\resource\\features', issues: 'AD-22', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
					catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
						bat 'mvn clean test -Dcucumber.options="--tags @smoke"'
					}
					bat 'mkdir ..\\target\\cucumber-reports\\Web-Smoke'
					bat 'copy target\\cucumber-reports\\Cucumber.json ..\\target\\cucumber-reports\\Web-Smoke\\Cucumber-smoke.json'
					step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart',importInfo:'''{
						"fields": {
							"project": {
								"id": "10000"
							},
							"summary": "Smoke Web Test Execution for Addressbook BDD (Generated By ${BUILD_TAG})",
							"issuetype": {
								"id": "10007"
							},
					   "labels":["smoke","Jenkins"],
							"customfield_10032" : [
							   "Dev"
							]
						}
					}''',testExecKey:'AD-23',inputInfoSwitcher:"fileContent",importFilePath: '..\\target\\cucumber-reports\\Web-Smoke\\Cucumber-smoke.json', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])												
				}
						
			}
		}
		stage("API Regression Test") {
			agent { label 'windows' }
			steps {
				dir('api') {
					echo 'API API regression Testing Stage'
					catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
						bat 'mvn clean test -Dcucumber.options="--tags @regression"'
					}						
					bat 'mkdir ..\\target\\cucumber-reports\\API-Regression'
					bat 'copy target\\surefire-reports\\com.virtusa.qa.api.product.json ..\\target\\cucumber-reports\\API-Regression\\API-regression.json'
					step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart',importInfo:'''{
						"fields": {
							"project": {
								"id": "10100"
							},
							"summary": "Regression Api Test Execution for BDD (Generated By ${BUILD_NUMBER})",
							"issuetype": {
								"id": "10007"
							},
					   "labels":["Regression","Jenkins","Api"],
							"customfield_10032" : [
							   "Dev"
							]
						}
					}''',inputInfoSwitcher:"fileContent",importFilePath: '\\target\\surefire-reports\\com.virtusa.qa.api.1_API-1.json', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
					bat 'del /f target\\surefire-reports\\com.virtusa.qa.api.product.json'
					bat 'del /f target\\surefire-reports\\com.virtusa.qa.api.1_API-1.json'
				}
			}
		}
		stage("Web Regression Test") {
			agent { label 'windows' }
			steps {
				dir('web') {
					echo 'Web regression Testing Stage'
					catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
						bat 'mvn test -Dcucumber.options="--tags @regression"'
					}							
					bat 'mkdir ..\\target\\cucumber-reports\\Web-Regression'
					bat 'copy target\\cucumber-reports\\Cucumber.json ..\\target\\cucumber-reports\\Web-Regression\\Cucumber-regression.json'
					bat 'del /f target\\cucumber-reports\\Cucumber.json'
					step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart',importInfo:'''{
						"fields": {
							"project": {
								"id": "10000"
							},
							"summary": "Regression Web Test Execution for Addressbook BDD (Generated By ${BUILD_TAG})",
							"issuetype": {
								"id": "10007"
							},
					   "labels":["Regression","Jenkins"],
							"customfield_10032" : [
							   "Dev"
							]
						}
					}''',inputInfoSwitcher:"fileContent",importFilePath: '..\\target\\cucumber-reports\\Web-Regression\\Cucumber-regression.json', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
				}
			}
			post {
				always {
						allure results: [[path: 'web\\target\\allure-results']]

				}
			}
		}
		stage("Desktop Test") {
			agent { label 'windows' }
			steps {
				dir('swing') {
					echo 'Testing Desktop'
						step([$class: 'XrayExportBuilder', filePath: '\\src\\test\\resource\\features', issues: 'SDA-5', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
					catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
						bat 'mvn clean test'
					}
					bat 'mkdir ..\\target\\cucumber-reports\\Desktop-Test'
					bat 'copy target\\cucumber-reports\\Cucumber.json ..\\target\\cucumber-reports\\Desktop-Test\\Cucumber-desktop.json'
					step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart',importInfo:'''{
						"fields": {
							"project": {
								"id": "10101"
							},
							"summary": " Desktop App Test Execution for BDD (Generated By Swing ${BUILD_NUMBER})",
							"issuetype": {
								"id": "10007"
							},
					   "labels":["Desktop","Jenkins"],
							"customfield_10032" : [
							   "Dev"
							]
						}
					}''',inputInfoSwitcher:"fileContent",importFilePath: '..\\target\\cucumber-reports\\Desktop-Test\\Cucumber-desktop.json', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
					bat 'del /f target\\cucumber-reports\\Cucumber.json'
				}
			}
		}
		stage("API performance test") {
			agent { label 'windows' }
			steps {
				dir('api_performance') {
					bat "del /f testresults.jtl"
					bat "E:\\apache-jmeter-5.2.1\\bin\\jmeter -n -t Product_Stress_Test.jmx -l testresults.jtl -e -o ${WORKSPACE}//api_performance//report"
				}
			}
			post {
				always {
					perfReport 'api_performance\\testresults.jtl'
				}
			}
		}
		stage("Cucumber Report generation") {
			agent { label 'windows' }
			steps {
				cucumber buildStatus: 'UNSTABLE',
				failedFeaturesNumber: 1,
				failedScenariosNumber: 1,
				skippedStepsNumber: 1,
				failedStepsNumber: 1,
				fileIncludePattern: '**/*.json',
				jsonReportDirectory: 'target\\cucumber-reports',
				sortingMethod: 'ALPHABETICAL',
				trendsLimit: 100   
			}
		post {
			always {
				hygieiaTestPublishStep buildStatus: "${currentBuild.currentResult}", testApplicationName: 'addressbook', testEnvironmentName: 'Dev', testFileNamePattern: 'Cucumber-smoke.json', testResultsDirectory: '\\target\\cucumber-reports\\Web-Smoke', testType: 'Functional'
				hygieiaTestPublishStep buildStatus: "${currentBuild.currentResult}", testApplicationName: 'addressbook', testEnvironmentName: 'Dev', testFileNamePattern: 'API-smoke.json', testResultsDirectory: '\\target\\cucumber-reports\\API-Smoke', testType: 'Functional'
				hygieiaTestPublishStep buildStatus: "${currentBuild.currentResult}", testApplicationName: 'addressbook', testEnvironmentName: 'Dev', testFileNamePattern: 'Cucumber-desktop.json', testResultsDirectory: '\\target\\cucumber-reports\\Desktop-Test', testType: 'Functional'
				hygieiaTestPublishStep buildStatus: "${currentBuild.currentResult}", testApplicationName: 'addressbook', testEnvironmentName: 'Dev', testFileNamePattern: 'Cucumber-regression.json', testResultsDirectory: '\\target\\cucumber-reports\\Web-Regression', testType: 'Functional'
				hygieiaTestPublishStep buildStatus: "${currentBuild.currentResult}", testApplicationName: 'addressbook', testEnvironmentName: 'Dev', testFileNamePattern: 'API-regression.json', testResultsDirectory: '\\target\\cucumber-reports\\API-Regression', testType: 'Functional'
				}
			}
		}
	}     
    tools {
        maven 'maven3.3.9'
        jdk 'openjdk8'
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
