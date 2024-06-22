pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    environment {
        // Definir la etiqueta para la imagen Docker
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // ID de las credenciales en Jenkins
        DOCKERHUB_USERNAME = "miguel073"
        IMAGE_NAME = "hello-world-miguel-tannia"
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
                script {
                    docker.build("${DOCKERHUB_USERNAME}/${IMAGE_NAME}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("${DOCKERHUB_USERNAME}/${IMAGE_NAME}").push('latest')
                    }
                }
            }
        }
    }
}
