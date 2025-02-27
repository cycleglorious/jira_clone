pipeline {
    agent {
        label 'node'
    }
    environment {
        ZIP_NAME = "build-${env.BUILD_ID}.zip"
        TEST_REPORT = 'tests_report.xml'
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
        parallel {
            stage('Lint') {
                steps {
                    sh './.jenkins/scripts/run-lint.sh'
                }
            }
            stage('Unit Tests') {
                steps {
                    sh "./.jenkins/scripts/run-tests.sh ${TEST_REPORT}"
                }
            }
        }

        stage('Build') {
            steps {
                sh "./.jenkins/scripts/build-app.sh ${ZIP_NAME}"
                archiveArtifacts artifacts: "${ZIP_NAME}", fingerprint: true
            }
            when {
                branch 'main'
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
            sh """
               sudo docker ps -q --filter "label=jenkins_build_id=${BUILD_ID}" | xargs -r docker stop
            """
        }
    }
}
