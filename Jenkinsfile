pipeline {
    agent any
    environment {
        IMAGE_NAME = 'My-simple-App-image'
        TAG_NAME = 'v1.0.0'
    }

    stages {
        stage('Maven Package') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -f Dockerfile -t cloudbci/simple-java-app/${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Login to GitHub Container Registry') {
            steps {
                script {
                   sh "docker login ghcr.io -u josliniyda27 -p ''"
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    sh "docker tag cloudbci/simple-java-app/${IMAGE_NAME}:latest ghcr.io/cloudbci/simple-java-app/${IMAGE_NAME}:${TAG_NAME}-alpha"

                }
            }
        }

        stage('Push Docker Image to GH Container Registry') {
            steps {
                script {
                    sh "docker push ghcr.io/cloudbci/simple-java-app/${IMAGE_NAME}:${TAG_NAME}-alpha"
                }
            }
        }
    }
}
