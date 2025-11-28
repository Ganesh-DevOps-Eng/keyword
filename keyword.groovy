pipeline {
    agent any

    stages {
        stage('Execute Robot Test') {
            steps {
                script {
                    sh 'chmod +x keyword.sh'
                    sh './keyword.sh'
                }
            }
        }
    }

    post {
        always {
            echo 'Post-build actions completed.'
        }
    }
}
