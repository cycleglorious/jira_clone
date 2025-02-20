pipeline {
  agent {
    label 'node'
  }

  stages {
    stage('Build') {
        steps {
          sh '''
            ./.jenkins/build-app.sh
          '''
        }
    }

    stage('Get artifact') {
      steps {
        sh '''
          ./.jenkins/get-artifact.sh
        '''
      }
    }
  }
}
