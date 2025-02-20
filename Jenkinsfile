pipeline {
    agent {
        label 'node'
    }

    options {
        timeout(time: 5, unit: 'MINUTES')
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh '''
                ./.jenkins/scripts/install-dependencies.sh
            '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                ./.jenkins/scripts/build-app.sh
            '''
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: '*.zip', fingerprint: true
        }
        cleanup {
            cleanWs()
            sh '''
            sudo docker stop $(sudo docker ps -a -q)
        '''
        }
    }
}
