pipeline {
    agent any
    environment {
        DOCKER_IMAGE_TAG = 'simple-java-app:1.0.0'
        GHCR_REGISTRY = 'ghcr.io'   
        ARTIFACTORY_URL = 'https://joslin2024.jfrog.io/'
        ARTIFACTORY_REPO = 'joslin2024.jfrog.io/container-images-docker-local'

	QUAY_USERNAME = 'josliniyda_j'
        QUAY_PASSWORD = 'gNcWSJrAV5FtTGF'
        QUAY_REGISTRY = 'quay.io'
        QUAY_REPO = 'cloudbeeci/simple-java-app'
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
                    sh "docker build -f Dockerfile-app -t ${DOCKER_IMAGE_TAG} ."
                }
            }
        }
	stage('Push to Jfrog-Artifactory') {
            steps {
                script {
		   withCredentials([usernamePassword(credentialsId: 'jfrog-docker-registry', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) 
		     {
			sh "docker login -u ${USERNAME} -p ${PASSWORD} ${ARTIFACTORY_URL}"
			sh "docker tag ${DOCKER_IMAGE_TAG} ${ARTIFACTORY_REPO}/${DOCKER_IMAGE_TAG}"
		        sh "docker push ${ARTIFACTORY_REPO}/${DOCKER_IMAGE_TAG}"
		     }		
                  }
	    	}
	    }

	stage('Push to Quay.io') {
            steps {
                script {
                    // Authenticate with Quay.io
                    docker.withRegistry("${QUAY_REGISTRY}", "${QUAY_USERNAME}", "${QUAY_PASSWORD}") {
                        // Push the Docker image to Quay.io
			sh "docker login -u ${QUAY_USERNAME} -p ${QUAY_PASSWORD} ${QUAY_REGISTRY}"
			sh "docker tag ${DOCKER_IMAGE_TAG} ${QUAY_REPO}/${DOCKER_IMAGE_TAG}"
		        sh "docker push ${DOCKER_IMAGE_TAG} ${QUAY_REPO}/${DOCKER_IMAGE_TAG}"
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

    

