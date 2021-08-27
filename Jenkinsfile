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
                    image 'registry.hiriko.local:5000/microsoft/dotnet:2.2-sdk'
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
                    image 'registry.hiriko.local:5000/microsoft/dotnet:2.2-sdk'
                }
            }
            steps{
                sh 'dotnet restore'
                sh 'dotnet test'
            }
        }
    
        stage('SonarQube'){
            options{
                timeout(time: 5, unit: 'MINUTES')
                retry(2)
            }
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