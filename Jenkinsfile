pipeline {
    agent {
        label 'node'
    }
    environment {
        ZIP_NAME = "build-${env.BUILD_ID}.zip"
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh '''
                ./.jenkins/scripts/install-dependencies.sh
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                ./.jenkins/scripts/run-tests.sh
                '''
                junit 'tests_report.xml'
            }
        }

        stage('Build') {
            steps {
                sh "./.jenkins/scripts/build-app.sh ${ZIP_NAME}"
                archiveArtifacts artifacts: "${ZIP_NAME}", fingerprint: true
            }
            // when {
            //     branch 'main'
            // }
        }

        stage('Deploy') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'Ansible control machine',
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false,
                                    excludes: '',
                                    execCommand: "ansible-playbook main.yml --tags app -e artifact_name=${ZIP_NAME}",
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
                            verbose: false
                        )
                    ]
                )
            }
            // when {
            //     branch 'main'
            // }
        }
    }

    post {
        cleanup {
            cleanWs()
            sh '''
            sudo docker stop $(sudo docker ps -a -q)
            '''
        }
    }
}
