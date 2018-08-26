pipeline {
    agent any 
    stages {
        stage('Checkout-git') { 
            steps {
                git poll: true, url: 'git@github.com:hacosta333/jenkinstest.git'
            }
        }
        stage('Create-VirtualEnv') { 
            steps {
                sh '''
			bash -c "virtualenv entorno_virtual && source entorno_virtual/bin/activate"
		'''
            }
        }
        stage('InstallRequirements') { 
            steps {
                sh '''
                        bash -c "source ${WORKSPACE}/entorno_virtual/bin/activate && ${WORKSPACE}/entorno_virtual/bin/python ${WORKSPACE}/entorno_virtual/bin/pip install -r requirements.txt"
                '''
            }
        }
        stage('TestApp'){
            steps {
		sh '''
                        bash -c "source ${WORKSPACE}/entorno_virtual/bin/activate && bash -c "source ${WORKSPACE}/entorno_virtual/bin/activate &&  cd src && ${WORKSPACE}/entorno_virtual/bin/python ${WORKSPACE}/entorno_virtual/bin/pytest && cd .."
                '''
            }
        }
        stage('RunApp'){
            steps {
                sh '''
                        bash -c "source entorno_virtual/bin/activate; ${WORKSPACE}/entorno_virtual/bin/python src/main.py &"
                '''
            }
        }
        stage('BuildDocker'){
            steps {
                sh '''
                        docker build -t python:latest .
                '''
            }
        }
        stage('PushDockerImage'){
            steps {
                sh '''
                        docker tag python:latest hacosta333/python:latest
			docker push hacosta333/python:latest
			docker rmi python:latest
                '''
            }
        }
        
    }
}
