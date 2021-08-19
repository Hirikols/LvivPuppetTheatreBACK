pipeline{
    agent any

    environment {
        scannerHome = tool 'sonar-scanner'
    }

    stages{
        stage('Compile App'){
            agent {
                docker{
                    image 'microsoft/dotnet:2.2-sdk'
                }
            }
            steps{
                sh 'dotnet restore '
                sh 'dotnet run --project=Web/Web.csproj --urls=http://0.0.0.0:5000'
            }
        }
        stage('Run Tests'){
            steps{
                sh 'dotnet test'
            }
        }
        stage('SonarQube'){
            steps{
                withSonarQubeEnv('Sonar'){
                    sh "${scannerHome}/bin/sonar-scanner \
                    -Dsonar.projectKey=TheareBack \
                    -Dsonar.sources=. "
                }
            }
        }
         stage('Quality gate') {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }

    }
    post{
        always{
            cleanWs()
        }
        success{
            //build next job
            echo 'nice!'
        }
    }
}