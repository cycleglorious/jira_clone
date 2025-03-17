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
        DOCKER_TEST_TAG = "${DOCKER_IMAGE}:test"
        DOCKER_LINT_TAG = "${DOCKER_IMAGE}:lint"
    }
    stages {
        stage('Setup env') {
            steps {
                echo 'Create .env with placeholders'
                writeFile file: '.env', text: """
                NODE_ENV='production'
                DATABASE_URL='postgresql://postgres:password@localhost:5432'
                UPSTASH_REDIS_REST_URL='http://localhost'
                UPSTASH_REDIS_REST_TOKEN='token'
                """
            }
        }
        stage('Lint') {
            steps {
                echo 'Linting the code'
                sh "docker build --build-arg LINT_REPORT=${LINT_REPORT} -t ${DOCKER_LINT_TAG} -o . --target lint_report ."

                echo 'Get lint results'
                recordIssues(tools: [esLint(pattern: "${LINT_REPORT}")])
            }
        }

        stage('Unit Tests') {
            steps {
                echo 'Running the tests'
                sh "docker build --build-arg TESTS_REPORT=${TEST_REPORT} -t ${DOCKER_TEST_TAG} -o . --target test_report ."

                echo 'Get test results'
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
            when {
                tag 'v*'
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
