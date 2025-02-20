pipeline {
  agent {
    label 'node'
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
