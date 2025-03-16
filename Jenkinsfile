pipeline {
    agent {
        label 'node'
    }
    environment {
        ZIP_NAME = "build-${env.TAG_NAME}.zip"
        TEST_REPORT = 'tests_report.xml'
        DOCKER_IMAGE = 'ghcr.io/cycleglorious/jira-clone'
        DOCKER_TAG = "${DOCKER_IMAGE}:0.0.0"
        DOCKER_LATEST = "${DOCKER_IMAGE}:latest"
    }
    tools {
        nodejs 'Node 22'
    }
    stages {
        stage('Install dependencies') {
            steps {
                echo 'Installing dependencies'
                sh 'npm ci'
                echo 'Creating .env file for placeholder configs'
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
                sh 'npm run lint'
            }
        }

        stage('Unit Tests') {
            steps {
                echo 'Running the tests'
                sh "npx vitest run > ${TEST_REPORT}"
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

        stage('Docker Build & Push') {
            steps {
                echo 'Building Docker image'
                sh "docker build -t ${DOCKER_TAG} -t ${DOCKER_LATEST} ."

                echo 'Pushing Docker image to Docker Hub'
                sh "docker push ${DOCKER_TAG}"
                sh "docker push ${DOCKER_LATEST}"
            }
        }

        stage('Create GitHub Release') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'github-fine-token-jira-clone', variable: 'GH_TOKEN')]) {
                        echo 'Creating GitHub release'
                        sh """
                            gh release create \
                            ${env.TAG_NAME} \
                            ${ZIP_NAME} \
                            --repo ${env.GIT_URL} \
                            --generate-notes
                        """
                    }
                }
            }
            when {
                tag 'v*'
            }
        }

        stage('Deploy') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'ansible-control-machine',
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false,
                                    excludes: '',
                                    execCommand: """
                                        cd /home/vagrant/ansible
                                        ansible-playbook main.yml --tags app -e artifact_name=${ZIP_NAME}
                                        """,
                                    execTimeout: 120000,
                                    flatten: false,
                                    makeEmptyDirs: false,
                                    noDefaultExcludes: false,
                                    patternSeparator: '[, ]+',
                                    remoteDirectory: 'roles/app_setup/files/',
                                    remoteDirectorySDF: false,
                                    removePrefix: '',
                                    sourceFiles: "${ZIP_NAME}")
                            ],
                            usePromotionTimestamp: false,
                            useWorkspaceInPromotion: false,
                            verbose: true
                        )
                    ]
                )
            }
            when {
                tag 'v*'
                branch 'main'
            }
        }
    }

    post {
        cleanup {
            cleanWs()
            sh 'docker system prune -af --volumes'
            sh 'docker logout'
        }
    }
}
