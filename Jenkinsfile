pipeline{
    agent any

    environment {
        scannerHome = tool 'sonar-scanner'
        DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
    }
   

    stages{
        stage('Compile App'){
            agent {
                docker{
                    image 'microsoft/dotnet:2.2-sdk'
                }
            }
            steps{
                sh 'dotnet restore'
                sh 'dotnet build "Web/Web.csproj" -c Release'
            }
        }

        stage('Run Tests'){
             agent {
                docker{
                    image 'microsoft/dotnet:2.2-sdk'
                }
            }
            steps{
                sh 'dotnet restore'
                sh 'dotnet test'
            }
        }
        // stage('Clean Docker'){

        // }
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