pipeline {
    agent { label "dev" }
    
    environment {
        DOCKER_IMAGE_NAME = "portfolio-website"
    }
    
    stages {
        stage("Clean WorkSpace") {
            steps {
                cleanWs()
            }
        }
        stage("Code") {
            steps {
                echo "This is cloning the code"
                git url: "https://github.com/sadiqueiqbal28/portfolio-website", branch: "main"
            }
        }
        stage("Build") {
            steps {
                echo "This is building the code"
                sh "docker build -t ${env.DOCKER_IMAGE_NAME} ."
            }
        }
        stage("Deliver") {
            steps {
                echo "This is delivering code"
                
                withCredentials([usernamePassword(
                    credentialsId: 'dockerHubCred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS')]) {
                    
                    echo "Tagging Docker Image"
                    sh "docker image tag ${env.DOCKER_IMAGE_NAME} ${env.DOCKER_USER}/${env.DOCKER_IMAGE_NAME}:latest"
                    
                    echo "Logging in Docker"
                    sh "docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_PASS}"
                    
                    echo "Delivering the Image"
                    sh "docker push ${env.DOCKER_USER}/${env.DOCKER_IMAGE_NAME}:latest"
                }
            }
        stage("Deploy") {
            steps {
                echo "Deploying code on k8s Cluster"
                sh "helm install portfollio-app k8s/portfolio*.tgz"
            }
        }
        }
    }
}