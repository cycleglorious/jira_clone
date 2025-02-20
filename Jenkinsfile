pipeline {
    agent {
        label 'node'
    }

    options {
        timeout(time: 5, unit: 'MINUTES')
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                ./.jenkins/scripts/build-app.sh
            '''
            }
        }

        stage('Get artifact') {
            steps {
                sh '''
            ./.jenkins/scripts/get-artifact.sh
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
        }
    }
}
