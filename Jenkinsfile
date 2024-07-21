pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/alinaleem/hello-world-web-app.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build the Docker image using Docker Compose
                    sh 'docker-compose build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run the Docker Compose services
                    sh 'docker-compose up -d'
                    
                    // Wait for the services to start
                    sleep 10
                    
                    // Run tests
                    sh 'curl http://localhost:3000'

                    // Stop the Docker Compose services
                    sh 'docker-compose down'
                }
            }
        }

         stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker Compose services
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}



