pipeline {
    agent any
    tools {
		jfrog 'jfrog-cli'
	}
    environment {
        IMAGE_NAME = 'joslin2024.jfrog.io/docker-local/simple-java-app-image:v1.0.2'
        //TAG_NAME = 'v1.0.2'
        GHCR_REGISTRY = 'ghcr.io'   
        ARTIFACTORY_URL = 'https://joslin24.jfrog.io/artifactory/'
        ARTIFACTORY_ACCESS_TOKEN = credentials('JFROG-TOKEN')
        ARTIFACTORY_REPO = 'container-images'
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

            stage('Scan and push docker image') {
			steps {
			  script {
				dir('joslin2024.jfrog.io/container-images-docker') {
					// Scan Docker image for vulnerabilities
					jfrog 'docker scan $IMAGE_NAME'

					// Push image to Artifactory
					jfrog 'docker push $IMAGE_NAME'
				}
			  }
			}
		}

            // stage('Push to Artifactory') {
            // steps {
            //     script {
            //         withCredentials([string(credentialsId: 'JFROG-TOKEN', variable: 'ARTIFACTORY_ACCESS_TOKEN')]) {
            //             // Log in to JFrog Artifactory with an access token
            //             //sh "jfrog rt c Jfrog-artifactory --url=${ARTIFACTORY_URL} --access-token=${ARTIFACTORY_ACCESS_TOKEN}"
            //             //sh "jfrog config add Jfrog-artifactory --artifactory-url=${ARTIFACTORY_URL}"
                
            //             // Push Docker image to Artifactory
            //            // sh "jfrog rt docker-push ${IMAGE_NAME } ${ARTIFACTORY_REPO} --build-name='Simple-Java-App' --build-number=1"
            //              sh "docker build -f Dockerfile-app -t simple-java-app-image:latest ."
            //             sh "jfrog rt docker-push simple-java-app-image:latest container-images --build-name=Simple-Java-App --build-number=1"

            //         }
            //       }
                stage('Publish build info') {
			        steps {
				        jfrog rtBuildPublish(buildName: 'my-build', buildNumber: '1')

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

    

