pipeline {
    agent {
        label 'node'
    }
    environment {
        ZIP_NAME = "build-${env.TAG_NAME}.zip"
        TEST_REPORT = 'tests_report.xml'
        GH_TOKEN = credentials('github-fine-token-jira-clone')
    }
    tools {
        nodejs 'Node 22'
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh "./.jenkins/scripts/install-dependencies.sh ${env.BUILD_ID}"
            }
        }
        stage('Lint and Test') {
            parallel {
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
            }
        }

        stage('Build') {
            steps {
                sh "./.jenkins/scripts/build-app.sh ${ZIP_NAME}"
                archiveArtifacts artifacts: "${ZIP_NAME}", fingerprint: true
            }
            when {
                anyOf {
                    tag 'v*'
                    branch 'main'
                }
            }
        }

        stage('Create GitHub Release') {
            steps {
                echo 'Creating GitHub release'
                sh """
                gh release create \
                    ${env.TAG_NAME} \
                    ${ZIP_NAME} \
                    --repo ${env.GIT_URL} \
                    --generate-notes
                """
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
                branch 'main'
            }
        }
    }

    post {
        cleanup {
            cleanWs()
            sh '''
            docker ps -q | xargs -r docker stop
            '''
        }
    }
}
