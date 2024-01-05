pipeline {
    agent any
    environment {
        IMAGE_NAME = 'cloudbci/simple-java-app/simple-java-app-image'
        TAG_NAME = 'v1.0.0'
        GHCR_REGISTRY = 'ghcr.io'
        GHCR_USERNAME = credentials('ghcr-username')  
        GHCR_TOKEN = credentials('ghcr-token')     
    }

    stages {
        stage('Maven Package') {
            steps {
                script{
                    sh "mvn clean package"
                    sh 'mv target/myweb*.war target/newapp.war'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -f Dockerfile -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        // stage('Login to GitHub Container Registry') {
        //     steps {
        //         script {
        //             sh "docker login -u ${GHCR_USERNAME} -p ${GHCR_TOKEN} ${GHCR_REGISTRY}"
        //         }
        //     }
        // }

        // stage('Tag Docker Image') {
        //     steps {
        //         script {
        //             // Tag the Docker image
        //             sh "docker tag ${IMAGE_NAME}:latest ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha"

        //         }
        //     }
        // }

        // stage('Push Docker Image to GH Container Registry') {
        //     steps {
        //         script {
        //             sh "docker push ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha"
        //         }
        //     }
        // }
            stage('Remove Previous Container'){
              steps {
                 script {
        	            try{
        		                sh 'docker rm -f tomcattest'
        	                }catch(error){
        		                //  do nothing if there is an exception
        	                }
                        }
              }
            }
            stage('Docker deployment'){
             steps {
                 script {
                       sh 'docker run -d -p 8081:8080 --name simple-java-app ${IMAGE_NAME}:latest' 
                       sh 'curl http://localhost:8081'
                   }
                }
            }
    }
}
