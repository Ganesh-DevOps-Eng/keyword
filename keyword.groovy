pipeline {
    agent any

    stages {
        stage('cleanup') {
            steps {
                script {
                    sh 'cd $WORKSPACE'
                    sh 'rm -rf newly-registered-domains*'
                    sh 'rm -rf domain-names.txt'
                }
            }
        }

        stage('excute') {
            steps {
                script {
                    sh 'cd $WORKSPACE'
                    sh 'chmod +x keyword.robot'
                    sh 'chmod +x keyword.sh'
                    sh './keyword.sh'
                }
            }
        }
    }

    post {
        always {
            // Clean up or perform any post-build actions if needed
            echo 'Post-build actions...'
        }
    }
}
