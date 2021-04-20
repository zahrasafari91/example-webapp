def buildImage
def productionImage
def ACCOUNT_REGISTRY_PREFIX
def GIT_COMMIT_HASH

pipeline {
    agent any
    stages {
        stage('Checkout Source Code and Logging into Registry') {
            steps {
                echo 'Logging into the Private Registry'
                script {
                    GIT_COMMIT_HASH = sh (script:"git log -n 1 --pretty=format:'%H'", returnStdout: true)
                    ACCOUNT_REGISTRY_PREFIX = "public.ecr.aws/g8q7b8u3"
                    sh """
                    \$(aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/g8q7b8u3)
                    """
                }
            }
        }

        stage('Build Image') {
            steps {
                echo 'Starting to build docker image'
                script {
                    buildImage = docker.build("${ACCOUNT_REGISTRY_PREFIX}/example-webapp-zsafarialamoti097:${GIT_COMMIT_HASH}", " .")
                    buildImage.push()
                    buildImage.push("${env.GIT_BRANCH}")
                }
            }
        }
    }
}