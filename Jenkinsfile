stage('Install Dependencies') {
    steps {
        script {

            // Check Chrome installed
            def chromeInstalled = sh(
                script: "command -v google-chrome >/dev/null 2>&1",
                returnStatus: true
            ) == 0

            // Check ChromeDriver installed
            def chromedriverInstalled = sh(
                script: "command -v chromedriver >/dev/null 2>&1",
                returnStatus: true
            ) == 0

            // Get Chrome version
            def chromeVersion = chromeInstalled ? sh(
                script: "google-chrome --version | awk '{print \$3}' | cut -d'.' -f1",
                returnStdout: true
            ).trim() : "0"

            // Get ChromeDriver version
            def driverVersion = chromedriverInstalled ? sh(
                script: "chromedriver --version | awk '{print \$2}' | cut -d'.' -f1",
                returnStdout: true
            ).trim() : "0"

            // Decide if dependencies need installation
            def mismatch = (chromeVersion != driverVersion)
            def needInstall = (!chromeInstalled || !chromedriverInstalled || mismatch)

            if (needInstall) {
                echo "Chrome or ChromeDriver missing/mismatch → Installing dependencies..."
                sh '''
                    sudo apt update
                    sudo apt install -y python3 python3-pip

                    pip3 install robotframework robotframework-seleniumlibrary selenium

                    # Install Google Chrome
                    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
                    sudo apt install -y ./google-chrome-stable_current_amd64.deb

                    # Install correct ChromeDriver
                    CHROME_VERSION=$(google-chrome --version | awk '{print $3}')
                    MAJOR=$(echo $CHROME_VERSION | cut -d'.' -f1)

                    wget -q https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip
                    unzip -o chromedriver-linux64.zip
                    sudo mv chromedriver-linux64/chromedriver /usr/bin/chromedriver
                    sudo chmod +x /usr/bin/chromedriver
                '''
            } else {
                echo "Chrome + ChromeDriver already installed and matching → Skipping installation."
            }
        }
    }
}

