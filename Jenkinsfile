pipeline {
    agent any
    tools {
		jfrog 'jfrog'
	}
    environment {
        IMAGE_NAME = 'simple-java-app-image'
        TAG_NAME = '1.0.3'
        GHCR_REGISTRY = 'ghcr.io'   
        ARTIFACTORY_URL = 'https://joslin2024.jfrog.io/artifactory/'
        //ARTIFACTORY_ACCESS_TOKEN = credentials('JFROG-TOKEN')
        ARTIFACTORY_REPO = 'joslin2024.jfrog.io/pipeline-iamges'
	DOCKER_REGISTRY = 'joslin2024.jfrog.io'
	JFROG_DOCKER_REGISTRY = credentials('jfrog-docker-registry')

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
                    docker.build("${IMAGE_NAME}:${TAG_NAME}", '-f Dockerfile-app .')
                }
            }
        }

	stage('Push to Artifactory') {
            steps {
                script {
                   //docker.withRegistry('https://joslin2024.jfrog.io', 'jfrog-docker-registry') {
		   withCredentials([usernamePassword(credentialsId: 'jfrog-docker-registry', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
    			sh "echo \$PASSWORD | docker login -u \$USERNAME --password-stdin https://joslin2024.jfrog.io"
			sh "docker tag ${IMAGE_NAME}:${TAG_NAME} ${ARTIFACTORY_REPO}/${IMAGE_NAME}:${TAG_NAME}"
		        sh "docker push ${ARTIFACTORY_REPO}/${IMAGE_NAME}:${TAG_NAME}"
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

    

