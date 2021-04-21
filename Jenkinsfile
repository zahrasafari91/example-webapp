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
                    ACCOUNT_REGISTRY_PREFIX = "237997119181.dkr.ecr.us-east-2.amazonaws.com"
                    sh """
                    \$(aws ecr get-login --no-include-email --region us-east-2)
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

        stage('Deploy to Production Fixed Server') {
            when {
                branch 'master'
            }
            steps {
                echo 'Deploying master to Fixed production'
                script {
                    buildImage.push("deploy")
                    sh """
                        aws ec2 reboot-instances --region us-east-2 --instance-ids i-009804063fc05185a
                    """
                }
            }
        }

        stage('Deploy to Production Cluster') {
            when {
                branch 'master'
            }
            steps {
                echo 'Deploying master to Cluster'
                script {
                    sh """
                    chmod +x -R ${env.WORKSPACE}
                    ./run-stack.sh example-webapp-production arn:aws:elasticloadbalancing:us-east-2:237997119181:listener/app/production-website/18f0633cae96d151/5d163e7f55bcb746
                    """
                }
            }
        }
    }
}