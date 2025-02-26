pipeline {
    agent {
        label 'node'
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
                sh '''
                ./.jenkins/scripts/build-app.sh
                '''
                archiveArtifacts artifacts: '*.zip', fingerprint: true
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
                            configName: 'Ansible control machine',
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false,
                                    excludes: '',
                                    execCommand: 'ansible-playbook main.yml --tags app',
                                    execTimeout: 120000,
                                    flatten: false,
                                    makeEmptyDirs: false,
                                    noDefaultExcludes: false,
                                    patternSeparator: '[, ]+',
                                    remoteDirectory: 'roles/app_setup/files/',
                                    remoteDirectorySDF: false,
                                    removePrefix: '',
                                    sourceFiles: '*.zip'
                                )
                            ],
                            usePromotionTimestamp: false,
                            useWorkspaceInPromotion: false,
                            verbose: false
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
            sudo docker stop $(sudo docker ps -a -q)
            '''
        }
    }
}
