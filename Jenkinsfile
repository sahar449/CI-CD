pipeline{
    //Directives
    agent any
    tools {
        maven 'maven'
    }

    stages {
        // Specify various stage with in stages

        // stage 1. Build
        stage ('Build'){
            steps {
                sh 'mvn clean install package'
            }
        }

        // Stage2 : Testing
        stage ('Test'){
            steps {
                echo ' testing......'

            }
        }
        // Stage3: Upload to Nexus
        stage ('upload to nexus'){
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'VinayDevOpsLab', classifier: '', file: 'target/VinayDevOpsLab-0.0.8.war', type: 'war']], credentialsId: '', groupId: 'com.vinaysdevopslab', nexusUrl: '172.20.10.100:8081', nexusVersion: 'nexus2', protocol: 'http', repository: 'snapshot', version: '0.0.8'
            }
        }  
        // Stage3 : Publish the source code to Sonarqube
//         stage ('Sonarqube Analysis'){
//             steps {
//                 echo ' Source code published to Sonarqube for SCA......'
//                 withSonarQubeEnv('sonarqube'){ // You can override the credential to be used
//                      sh 'mvn sonar:sonar'
//                 }

//             }
//         }

        
        
//     }
    }
}
