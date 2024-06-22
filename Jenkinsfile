pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    environment {
        // Definir la etiqueta para la imagen Docker
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // ID de las credenciales en Jenkins
        DOCKERHUB_USERNAME = "${DOCKERHUB_CREDENTIALS_USR}"
        IMAGE_NAME = "my-hello-world"
    }
 
    stages {
        stage('Build') {
            steps {
                bat 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                // Construir la imagen Docker
                script {
                    docker.build dockerImageTag
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                // Subir la imagen Docker a Docker Hub
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image(dockerImageTag).push()
                    }
                }
            }
        }
    }
    }
