pipeline {
    agent any
    tools {
		jfrog 'jfrog'
	}
    environment {
        IMAGE_NAME = 'simple-java-app-image:v1.0.2'
        //TAG_NAME = 'v1.0.2'
        GHCR_REGISTRY = 'ghcr.io'   
        ARTIFACTORY_URL = 'https://joslin2024.jfrog.io/artifactory/'
        ARTIFACTORY_ACCESS_TOKEN = credentials('JFROG-TOKEN')
        ARTIFACTORY_REPO = 'container-images-docker-local'
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
                    //sh "docker build -f Dockerfile-app -t ${IMAGE_NAME} ."
                    docker.build("$IMAGE_NAME", '-f Dockerfile-app .')
                }
            }
        }

	stage('Push to Artifactory') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'JFROG-TOKEN', variable: 'ARTIFACTORY_ACCESS_TOKEN')]) {               
                        // Push Docker image to Artifactory
                       sh "jfrog rt docker-push ${IMAGE_NAME} ${ARTIFACTORY_REPO} --url=${ARTIFACTORY_URL} --build-name=Simple-Java-App --build-number=1 --access-token=${ARTIFACTORY_ACCESS_TOKEN}"
			}
                  }
	    	}
	    }

        //  stage('Login to GitHub Container Registry') {
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

  //           stage('Build and Scan and push docker image') {
		// 	steps {
		// 	  script {
		// 		dir('joslin2024.jfrog.io/container-images-docker') {
		// 			//build docker image
		// 			docker.build("$IMAGE_NAME", '-f Dockerfile-app .')
					
		// 			// Scan Docker image for vulnerabilities
		// 			jfrog 'docker scan $IMAGE_NAME'

		// 			// Push image to Artifactory
		// 			jfrog 'docker push $IMAGE_NAME'
		// 		}
		// 	  }
		// 	}
		// }                
      
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

    

