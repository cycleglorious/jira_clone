pipeline {
  agent {
    label 'node'
  }

  stages {
    stage('Build') {
      timeout(time: 5, unit: 'MINUTES') {
        steps {
          sh './.jenkins/build-app.sh'
        }
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
