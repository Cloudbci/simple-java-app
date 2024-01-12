pipeline {
    agent none
    environment {
        IMAGE_NAME = 'cloudbci/simple-java-app/simple-java-app-image'
        TAG_NAME = 'v1.0.0'
        GHCR_REGISTRY = 'ghcr.io'   
    }

    stages {
        stage('Maven Package') {
            agent {
                docker { image 'maven:3.8.1-adoptopenjdk-11' }
              }
            steps {
                script{
                    sh "mvn clean install"
                    sh 'mv target/myweb*.war target/newapp.war'
                }
            }
        }

        stage('Build Docker Image') {
            agent {
                dockerfile true
              }
            steps {
                script {
                    sh "docker build -f Dockerfile-app -t ${IMAGE_NAME}:latest ."
                }
            }
        }

         stage('Login to GitHub Container Registry') {
             agent any
             steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'GitHub-Token', usernameVariable: 'GHCR_USERNAME', passwordVariable: 'GHCR_TOKEN')]) {
                    sh "echo ${GHCR_TOKEN} | docker login --username ${GHCR_USERNAME} --password-stdin ghcr.io" }
                }
            }
         }

        stage('Tag Docker Image') {
            agent any
            steps {
                script {
                    sh "docker tag ${IMAGE_NAME}:latest ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha"

                }
            }
        }

        stage('Push Docker Image to GH Container Registry') {
            agent any
            steps {
                script {
                    sh "docker push ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha"
                }
            }
        }
            stage('Remove Previous Container'){
                agent any
              steps {
                 script {
        	            try{
        		                sh 'docker rm -f simple-java-app'
        	                }catch(error){
        		                //  do nothing if there is an exception
        	                }
                        }
              }
            }
            stage('Docker deployment'){
                agent any
             steps {
                 script {
                       sh 'docker run -dit -p 8081:8080 --name simple-java-app ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha' 
                   }
                }
            }
    }
}
