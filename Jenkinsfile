pipeline {
    agent {
        label 'node'
    }
    environment {
        ZIP_NAME = "build-${env.TAG_NAME}.zip"
        TEST_REPORT = 'tests_report.xml'
        LINT_REPORT = 'lint-report.xml'
        DOCKER_IMAGE = 'ghcr.io/cycleglorious/jira-clone'
        DOCKER_TAG = "${env.TAG_NAME.replaceFirst(/^v/, '')}"
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE}:${DOCKER_TAG}"
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
            environment {
                LINT_LOGS_FILE = "${LINT_REPORT}.log"
            }
            steps {
                echo 'Linting the code'
                sh "docker build -t ${DOCKER_LINT_TAG} --target lint --progress=plain . 2> ${LINT_LOGS_FILE}"
            }

            post {
                always {
                    sh "cat ${LINT_LOGS_FILE}"
                    echo 'Get lint report'
                    sh """
                    awk '/<?xml /,/<\\/checkstyle>/ { sub(/^#.*[0-9]\\.[0-9]* /, ""); print }' ${LINT_LOGS_FILE} > ${LINT_REPORT}
                    """
                    recordIssues(tools: [esLint(pattern: "${LINT_REPORT}")])
                }
            }
        }

        stage('Unit Tests') {
            environment {
                TEST_LOGS_FILE = "${TEST_REPORT}.log"
            }
            steps {
                echo 'Running the tests'
                sh "docker build -t ${DOCKER_TEST_TAG} --target test --progress=plain . 2> ${TEST_LOGS_FILE}"
            }
            post {
                always {
                    sh "cat ${TEST_LOGS_FILE}"
                    echo 'Get test report'
                    sh """
                    awk '/<?xml /,/<\\/testsuites>/ { sub(/^#.*[0-9]\\.[0-9]* /, ""); print }' ${TEST_LOGS_FILE} > ${TEST_REPORT}
                    """
                    junit "${TEST_REPORT}"
                }
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
            when {
                tag 'v*'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image'
                sh "docker build -t ${DOCKER_IMAGE_TAG} -t ${DOCKER_LATEST} ."
            }
            when {
                tag 'v*'
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
