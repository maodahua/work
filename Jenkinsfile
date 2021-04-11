pipeline {
    agent any
    stages {
        // stage('Clone') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/maodahua/work.git'
        //     }
        // }
        stage('Java Build') { 
            steps {
                withMaven(
                    maven: 'maven') {
                       sh 'mvn clean package -Dmaven.test.skip=true' 
                    }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerhubPassword', usernameVariable: 'dockerhubUser')]) {
                            sh "docker login -u ${dockerhubUser} -p ${dockerhubPassword}"  
                    }    
                    if ("${depenv}" == "dev") {
                         sh '''
                            cp target/work.war dev/app/
                            cd dev/app
                            docker build -t maodahua16/dev_app:'''+verison+''' .                          
                            cd ../web/
                            docker build -t maodahua16/dev_web:'''+verison+''' .
                            docker push maodahua16/dev_app:'''+verison+'''
                            docker push maodahua16/dev_web:'''+verison+'''
                         '''
                    }
                    else if ("${depenv}" == "prod")  {
                        sh '''
                            cp target/work.war prod/app/
                            cd prod/app
                            docker build -t maodahua16/prod_app:'''+verison+''' .
                            cd ../web/
                            docker build -t maodahua16/prod_web:'''+verison+''' .
                            docker push maodahua16/prod_app:'''+verison+'''
                            docker push maodahua16/prod_web:'''+verison+'''
                         '''
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {      
                    if ("${depenv}" == "dev") {
                         sh '''
                            cd dev
                            sed -i 's/<ver>/${verison}/g' docker-compose.yml
                            docker-compose up -d
                         '''
                    }
                    else if ("${depenv}" == "prod")  {
                        sh '''
                           cd prod
                           sed -i 's/<ver>/${verison}/g' docker-compose.yml
                           docker-compose up -d
                         '''
                    }
                }
            }
        }
    }
}