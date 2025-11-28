pipeline {
    agent any

    stages {
        stage('Run Robot Tests') {
            steps {
                // Just call your existing shell script
                sh './keyword.sh'
            }
        }

        stage('Archive Reports') {
            steps {
                archiveArtifacts artifacts: '*.html', fingerprint: true
            }
        }
    }
}

