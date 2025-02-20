pipeline {
  agent {
    label 'node'
  }

  stages {
    stage('Build') {
        steps {
          sh '''
            whoami
            docker ps
            sudo docker ps
          '''
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
