pipeline {
    agent { label 'ubuntu' }
    //agent any
    environment {
        IMAGE_NAME = 'cloudbci/simple-java-app/simple-java-app-image'
        TAG_NAME = 'v1.0.2'
        GHCR_REGISTRY = 'ghcr.io'   
        ARTIFACTORY_URL = 'https://joslin24.jfrog.io/artifactory/'
        ARTIFACTORY_ACCESS_TOKEN = credentials('JFROG-TOKEN')
        ARTIFACTORY_REPO = 'container-images'
    }

    stages {
        stage('Maven Package') {
            // agent { 
            //     image 'maven:3.8.4-adoptopenjdk-11'
            //     }
            
            steps {
                script{
                    sh "mvn clean install"
                    sh 'mv target/myweb*.war target/newapp.war'
                }
            }
        }

        stage('Build Docker Image') {
            //agent { label 'ubuntu' }            
            steps {
                script {
                    sh "docker build -f Dockerfile-app -t ${IMAGE_NAME}:${TAG_NAME} ."
                }
            }
        }

        //  stage('Login to GitHub Container Registry') {
        //      agent { label 'ubuntu' } 
        //      steps {
        //         script {
        //             withCredentials([usernamePassword(credentialsId: 'GitHub-Token', usernameVariable: 'GHCR_USERNAME', passwordVariable: 'GHCR_TOKEN')]) {
        //             sh "echo ${GHCR_TOKEN} | docker login --username ${GHCR_USERNAME} --password-stdin ghcr.io" }
        //         }
        //     }
        //  }

        // stage('Tag Docker Image') {
        //     agent { label 'ubuntu' } 
        //     steps {
        //         script {
        //             sh "docker tag ${IMAGE_NAME}:latest ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha"

        //         }
        //     }
        // }

        // stage('Push Docker Image to GH Container Registry') {
        //     agent { label 'ubuntu' } 
        //     steps {
        //         script {
        //             sh "docker push ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha"
        //         }
        //     }
        // }

            stage('Push to Artifactory') {
            steps {
                script {
                   // Log in to JFrog Artifactory with an access token
                    sh "jfrog rt config --url=${ARTIFACTORY_URL} --access-token=${ARTIFACTORY_ACCESS_TOKEN} --interactive=false"

                    // Push Docker image to Artifactory
                    sh "jfrog rt docker-push ${IMAGE_NAME}:${TAG_NAME} ${ARTIFACTORY_REPO} --build-name=${IMAGE_NAME} --build-number=1"
                }
            }
        }
            // stage('Remove Previous Container'){
            //   agent { label 'ubuntu' } 
            //   steps {
            //      script {
        	   //          try{
        		  //               sh 'docker rm -f simple-java-app'
        	   //              }catch(error){
        		  //               //  do nothing if there is an exception
        	   //              }
            //             }
            //   }
            // }
            // stage('Docker deployment'){
            //  agent { label 'ubuntu' } 
            //  steps {
            //      script {
            //            sh 'docker run -dit -p 8081:8080 --name simple-java-app ${GHCR_REGISTRY}/${IMAGE_NAME}:${TAG_NAME}-alpha' 
            //        }
            //     }
            // }
        
    }
}

    

