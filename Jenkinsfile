pipeline {
  agent {
    docker {
      image 'node:20'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh '''npm ci
npm run build'''
      }
    }

    stage('Get artifact') {
      steps {
        echo 'here scrip to get artifact'
      }
    }

  }
}