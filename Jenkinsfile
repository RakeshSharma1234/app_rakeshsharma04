pipeline {
    agent any
    
	tools {
		maven 'Maven3'
	}
	
   environment {
    SonarScanner = tool 'SonarQubeScanner'
    Current_Branch = "${env.BRANCH_NAME}" 
   }
   
    stages {
        stage('Build') {
          steps {
                echo "Build Started ..."
		
                sh 'mvn -B -DskipTests clean install'
            
                echo "Build Finished ..."
          }
        }
        
        stage('Test case execution') {
          when {
                branch 'master'
            }
          steps {
                echo "Test case execution Started ..."
                    
                sh 'mvn test'
                
                echo "Test case execution Finished ..."
          }
        }
        
        stage('Sonarqube Analysis') {
            when {
                branch 'develop'
            }
            steps{
                 echo "Sonarqube Analysis Started ..."
                     
                  withSonarQubeEnv('Test_Sonar') {
                          sh '$SonarScanner/bin/sonar-scanner  -Dsonar.java.binaries=target/classes/ -Dsonar.java.libraries=target/**/*.jar  -Dsonar.projectKey=sonar-rakeshsharma04  -Dsonar.sources=src/main/java'
                  }
                     
                 echo "Sonarqube Analysis Finished ..."
            }
        }
        
        stage('Kubernetes Deployment') {
            steps{
                 echo "Kubernetes Deployment Started ..."
                 script {
			 if (env.BRANCH_NAME == "develop") {
			      sleep 30
			 }
			 sh '''
			      sed -i -e "s#BRANCH_NAME#$Current_Branch#g" deployment.yml
			      kubectl apply -f deployment.yml
			    '''
		  }
                 echo "Kubernetes Deployment Finished ..."
            }
        }
    }
}
