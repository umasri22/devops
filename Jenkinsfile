pipeline {
    agent { label 'master' }
    stages {
        
        stage('Test Script Checkout and Execution')
        {
           agent { label 'windows' }
            stages {
                stage("Checkout") {
                    steps {
                         checkout([  
                            $class: 'GitSCM', 
                            branches: [[name: 'refs/heads/master']], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'bdd']], 
                            submoduleCfg: [], 
                            userRemoteConfigs: [[credentialsId: 'rakeshgitvirtusatoken', url: 'https://git.virtusa.com/intelligent-automation/web_bdd.git']]
                        ])
                        checkout([  
                            $class: 'GitSCM', 
                            branches: [[name: 'refs/heads/master']], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'api']], 
                            submoduleCfg: [], 
                            userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/IATVirtusa/APITests.git']]
                        ])
			 checkout([  
                            $class: 'GitSCM', 
                            branches: [[name: 'refs/heads/master']], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'swing']], 
                            submoduleCfg: [], 
                            userRemoteConfigs: [[credentialsId: 'rakeshgitvirtusatoken', url: 'https://git.virtusa.com/intelligent-automation/swing_bdd.git']]
                        ])
                    } 
                }
	    	stage("Unit Test") {
                  steps {
                     echo ' Unit Test Stage'
                        bat 'mvn test'
			junit 'target\\surefire-reports\\*.xml'			
                        }
                    } 
                stage('Export Cucumber') {
		    steps {
			dir('bdd') {
		        	step([$class: 'XrayExportBuilder', filePath: '\\src\\test\\resource\\features', issues: 'XRAYD-11', serverInstance: 'ce436e2b-0499-443c-9431-1864e5d99242'])
			}
		    }
		}
                stage("Web Smoke Test") {
                    steps {
                        dir('bdd') {
                        echo 'Testing Stage'
			//step([$class: 'XrayExportBuilder', filePath: '\\src\\test\\resource\\features', issues: 'XRAYD-11', serverInstance: 'jiraserver'])
                        bat 'mvn test -Dcucumber.option="--tags @smoke"'
			//step([$class: 'XrayImportBuilder', endpointName: '/cucumber', importFilePath: '\\target\\cucumber-reports\\Cucumber.json', serverInstance: 'jiraserver'])
                        bat 'copy target\\cucumber-reports\\Cucumber.json target\\cucumber-reports\\Cucumber-smoke.json'
                        }
                    } 
		}
                stage("API Smoke Test") {
                    steps {
                        dir('api') {
                        echo 'Testing Stage'
                        bat 'mvn clean test -Dcucumber.option="--tags @smoke"'
                        bat 'copy target\\surefire-reports\\com.virtusa.qa.api.product.json D:\\workspace\\workspace\\addressbook\\bdd\\target\\cucumber-reports\\API-smoke.json'
                        }
                    } 
                }
                /*stage("Web Feature Test") {
                    steps {
                        dir('web') {
                        echo 'Testing Stage'
                        bat 'mvn test -Dcucumber.option="--tags @feature"'
                        bat 'copy target\\cucumber-reports\\Cucumber.json target\\cucumber-reports\\Cucumber-sanity.json'
                        bat 'del /f target\\cucumber-reports\\Cucumber.json'
                        }
                    }
                }
                stage("API Feature Test") {
                    steps {
                        dir('api') {
                        echo 'Testing Stage'
                        bat 'mvn test -Dcucumber.option="--tags @feature"'
                        bat 'copy target\\surefire-reports\\com.virtusa.qa.api.product.json D:\\workspace\\workspace\\addressbook\\bdd\\target\\cucumber-reports\\API-feature.json'
                        bat 'del /f target\\cucumber-reports\\Cucumber.json'
                        }
                    }
                }*/
                stage("Web Regression Test") {
                    steps {
                        dir('bdd') {
                        echo 'Testing Stage'
                        bat 'mvn test'
                        bat 'copy target\\cucumber-reports\\Cucumber.json target\\cucumber-reports\\Cucumber-regression.json'
			bat 'del /f target\\cucumber-reports\\Cucumber.json'
			//bat 'copy target\\jacoco.exec D:\\workspace\\workspace\\addressbook\\target\\jacoco-web.exec'
			
                        }
                    }
                }
                stage("API Regression Test") {
                    steps {
                        dir('api') {
                        echo 'Testing Stage'
                        bat 'mvn clean test'
                        bat 'copy target\\surefire-reports\\com.virtusa.qa.api.product.json D:\\workspace\\workspace\\addressbook\\bdd\\target\\cucumber-reports\\API-Regression.json'
			bat 'del /f target\\surefire-reports\\com.virtusa.qa.api.product.json'
                        }
                    }
                }
		    
		stage("Desktop Test") {
                    steps {
                        dir('swing') {
                        echo 'Testing Desktop stage'
                        bat 'mvn test'
                        bat 'copy target\\cucumber-reports\\Cucumber.json D:\\workspace\\workspace\\addressbook\\bdd\\target\\cucumber-reports\\Cucumber-desktop.json'
			bat 'del /f target\\cucumber-reports\\Cucumber.json'
			//bat 'copy target\\jacoco.exec D:\\workspace\\workspace\\addressbook\\target\\jacoco-web.exec'
			
                        }
                    }
                }

                stage("Jacoco Code Coverage report") {
                    steps {
          		  dir('D:\\workspace\\workspace\\addressbook\\') {
                         jacoco(execPattern: 'target\\*.exec')
        		    }
                        }
                    } 
		        
                /*stage("Sanity Test") {
                    steps {
                        dir('bdd') {
                        echo 'Testing Stage'
                        bat 'mvn test -Dcucumber.option="--tags @sanity'
                        bat 'copy target\\cucumber-reports\\Cucumber.json target\\cucumber-reports\\Cucumber-sanity.json'
                        bat 'del /f target\\cucumber-reports\\Cucumber.json'
                        }
                    }
                }*/
                
                stage("Cucumber-report view") {
                    steps {
					    
                        cucumber buildStatus: 'UNSTABLE',
                            failedFeaturesNumber: 1,
                            failedScenariosNumber: 1,
                            skippedStepsNumber: 1,
                            failedStepsNumber: 1,
                            classifications: [
                                    [key: 'Commit', value: '<a href="${GERRIT_CHANGE_URL}">${GERRIT_PATCHSET_REVISION}</a>'],
                                    [key: 'Submitter', value: '${GERRIT_PATCHSET_UPLOADER_NAME}']
                            ],
                            fileIncludePattern: '**/*.json',
                            sortingMethod: 'ALPHABETICAL',
                            trendsLimit: 100   
                    }
                }
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
