pipeline {
    agent { label 'master' }
    stages {
        
        stage('Build') {
            steps {
                echo 'Clean Build'
                    sh "ls"
                    sh "pwd"
                    sh "mvn sonar:sonar clean compile -Dtest=\\!TestRunner* -DfailIfNoTests=false -Dsonar.projectKey=employee_jdbc -Dsonar.host.url=http://10.62.125.4:8085/ -Dsonar.login=f16fabd2605044f38e79e4c0e4bc5f73c55dd144"
                    //sh "mvn sonar:sonar clean compile -Dtest=\\!TestRunner* -DfailIfNoTests=false -Dsonar.projectKey=employee_jdbc -Dsonar.host.url=http://34.93.123.206/ -Dsonar.login=aac7cc7809ddc82ce0070e3f74726c71216936b6"
                    //sh 'mvn clean compile' 
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging'
                sh 'mvn package -DskipTests'
            }
        }
        stage("publish to nexus") {
            steps {
                script {
                    // Read POM xml file using 'readMavenPom' step , this step 'readMavenPom' is included in: https://plugins.jenkins.io/pipeline-utility-steps
                    pom = readMavenPom file: "pom.xml";
                    // Find built artifact under target folder
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    // Print some info from the artifact found
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    // Extract the path from the File found
                    artifactPath = filesByGlob[0].path;
                    // Assign to a boolean response verifying If the artifact name exists
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                // Artifact generated such as .jar, .ear and .war files.
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging]//,
                                // Lets upload the pom.xml file for additional information for Transitive dependencies
                                /*[artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]*/
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'curl --upload-file target/addressbook.war "http://tomcat:password@10.62.125.4:8083/manager/text/deploy?path=/addressbook&update=true"'
                //sh 'curl --upload-file target/addressbook.war "http://tomcat:password@34.93.238.186:8081/manager/text/deploy?path=/addressbook&update=true"'
                //withCredentials([usernamePassword(credentialsId: 'nexusadmin', passwordVariable: 'pass', usernameVariable: 'user')]) {
                //    sh 'curl --upload-file target/hello-world-war-1.0.0-SNAPSHOT.war "http://${user}:${pass}@34.93.240.217:8082/manager/text/deploy?path=/hello&update=true"'
                //}
            }
        }
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
                        dir('bdd') {
                        echo 'Testing Stage'
                        bat 'mvn test'
                        }
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
            dir('bdd') {
             cucumber buildStatus: 'UNSTABLE',
                failedFeaturesNumber: 1,
                failedScenariosNumber: 1,
                skippedStepsNumber: 1,
                failedStepsNumber: 1,
                classifications: [
                        [key: 'Commit', value: '<a href="${GERRIT_CHANGE_URL}">${GERRIT_PATCHSET_REVISION}</a>'],
                        [key: 'Submitter', value: '${GERRIT_PATCHSET_UPLOADER_NAME}']
                ],
                fileIncludePattern: 'target/cucumber-reports/Cucumber.json',
                sortingMethod: 'ALPHABETICAL',
                trendsLimit: 100
            }
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
