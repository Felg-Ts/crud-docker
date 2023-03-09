pipeline {
    environment {
        IMAGEN = "felgts/crudphp"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent none
    stages {
        stage("Construccion") {
            agent any
            stages {
                stage('CloneAnfitrion') {
                    steps {
                        git branch:'main',url:'https://github.com/Felg-Ts/crudphp_prueba_docker.git'
                    }
                }
                stage('BuildImage') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:latest"
                        }
                    }
                }
                stage('UploadImage') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('RemoveImage') {
                    steps {
                        sh "docker rmi $IMAGEN:latest"
                    }
                }
                stage ('SSH') {
                    steps{
                        sshagent(credentials : ['SSH_USER']) {
                        sh 'ssh -o StrictHostKeyChecking=no retr0@pyramidhead.ringedbeak.com wget https://raw.githubusercontent.com/Felg-Ts/Docker-python-django/main/docker-compose.yml -O docker-compose.yaml'
                        sh 'ssh -o StrictHostKeyChecking=no retr0@pyramidhead.ringedbeak.com docker pull $IMAGEN:latest'
                        sh 'ssh -o StrictHostKeyChecking=no retr0@pyramidhead.ringedbeak.com docker-compose up -d --force-recreate django-tutorial'
                    }
    }
}
            }
        }           
    }
    post {
        always {
            mail to: 'el-feli-rubio1996@hotmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
