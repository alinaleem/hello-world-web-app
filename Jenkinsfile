pipeline {
    agent any

    environment {
        // Ensure Docker Compose is in the PATH
        PATH = "$PATH:/usr/local/bin"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from Git repository..."
                git branch: 'main', url: 'https://github.com/alinaleem/hello-world-web-app'
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Building Docker image using Docker Compose..."
                    // Build the Docker image using Docker Compose
                    sh 'docker-compose build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Running Docker Compose services..."
                    // Run the Docker Compose services
                    sh 'docker-compose up -d'
                    
                    // Wait for the services to start
                    echo "Waiting for services to start..."
                    sleep 10
                    
                    // Run tests
                    echo "Running tests..."
                    sh 'curl http://localhost:3000'

                    // Stop the Docker Compose services
                    echo "Stopping Docker Compose services..."
                    sh 'docker-compose down'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying Docker Compose services..."
                    // Deploy the Docker Compose services
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Cleaning workspace..."
                cleanWs()
            }
        }
        failure {
            script {
                echo "Pipeline failed, printing Docker Compose logs..."
                // Print Docker Compose logs on failure
                sh 'docker-compose logs'
                echo "Stopping Docker Compose services..."
                sh 'docker-compose down'
            }
        }
    }
}
