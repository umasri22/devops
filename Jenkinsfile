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
                            userRemoteConfigs: [[credentialsId: 'rakeshgitvirtusatoken', url: 'https://git.virtusa.com/intelligent-automation/bdd.git']]
                        ])
                    } 
                }
                stage("Test Execution") {
                    steps {
                        echo 'Testing - Dummy Stage'
                        bat 'D:\\workspace\\workspace\\addressbook\\bdd mvn test'
                    } 
                }
            }     
        }
        /*stage('Artifact Promotion') {
            steps {
                artifactPromotion (
                    promoterClass: 'org.jenkinsci.plugins.artifactpromotion.NexusOSSPromotor',
                debug: false,
                    groupId: 'com.edurekademo.tutorial',
                    artifactId: 'addressbook',
                    version: '2.0-SNAPSHOT',
                    extension: 'war',
                    //stagingRepository: 'http://nexus.myorg.com:8080/content/repositories/release-candidates',
                    stagingRepository: 'http://34.93.7.213:8081/repository/maven-snapshots',
                    stagingUser: 'admin',
                    stagingPW: 'admin123',
                    skipDeletion: true,
                    releaseRepository: 'http://34.93.7.213:8081/repository/maven-releases',
                    releaseUser: 'admin',
                    releasePW: 'admin123'
                )
            }
        }*/
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
