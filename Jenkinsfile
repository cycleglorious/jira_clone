pipeline {
  agent {
    node {
      label 'any'
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