pipeline {
  agent {
    label 'node'
  }

  stages {
    stage('Build') {
        steps {
          sh './.jenkins/build-app.sh'
        }
    }

    stage('Get artifact') {
      steps {
        echo 'here scrip to get artifact'
        sh 'ls'
      }
    }
  }
}
