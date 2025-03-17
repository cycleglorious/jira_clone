pipeline {
    agent {
        label 'node'
    }
    environment {
        ZIP_NAME = "build-${env.TAG_NAME}.zip"
        TEST_REPORT = 'tests_report.xml'
        LINT_REPORT = 'lint-report.json'
        DOCKER_IMAGE = 'ghcr.io/cycleglorious/jira-clone'
        DOCKER_TAG = "${DOCKER_IMAGE}:0.0.0"
        DOCKER_LATEST = "${DOCKER_IMAGE}:latest"
        DOCKER_TEST_TAG = "${DOCKER_TAG}-test"
        DOCKER_LINT_TAG = "${DOCKER_TAG}-lint"
    }
    stages {
        stage('Lint') {
            steps {
                echo 'Linting the code'
                sh "docker build --build-arg LINT_REPORT=${LINT_REPORT} -t ${DOCKER_LINT_TAG} --target lint ."
            }
        }

        stage('Unit Tests') {
            steps {
                echo 'Running the tests'
                sh "docker build --build-arg TESTS_REPORT=${TEST_REPORT} -t ${DOCKER_TAG}-test --target test ."

                echo 'Get test results'
                sh """
                    docker create --name extract-container ${DOCKER_TEST_TAG}
                    docker cp extract-container:${TEST_REPORT} .
                """

                junit "${TEST_REPORT}"
            }
        }

        stage('Docker login') {
            steps {
                echo 'Logging in to Docker Hub'
                script {
                    withCredentials([usernamePassword(credentialsId: 'ghcr-token', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'echo $PASSWORD | docker login ghcr.io -u $USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image'
                sh "docker build -t ${DOCKER_TAG} -t ${DOCKER_LATEST} ."
            }
        }

        stage('Docker Push') {
            steps {
                echo 'Pushing Docker image to ghcr.io'
                sh "docker push ${DOCKER_TAG}"
                sh "docker push ${DOCKER_LATEST}"
            }
        }
    }

    post {
        cleanup {
            cleanWs()
            sh 'docker logout'
            sh 'docker system prune -fa'
        }
    }
}
