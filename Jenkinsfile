#!groovy

pipeline {
  agent any
  options {
        timeout(time: 300, unit: 'SECONDS') 
    }
 	environment {
        path11 = sh(returnStdout: true, script: 'pwd')
    }
  stages 
    {
    stage('SNYK') {
      steps {
		snykSecurity failOnIssues: false, snykInstallation: 'pulgin', snykTokenId: 'snyk'      
	    }

		  }
    stage('Build and push docker images') 
			{
      				steps {
        				sh 'docker build -t akhilank1937/first .'

        				withDockerRegistry([ credentialsId: "DockerHub", url: "" ]) {
         						sh 'docker push akhilank1937/first:latest'
        				  }
    			}
    		}
    stage('anchore'){
    	steps{

	  	writeFile file: "anchore_images", text: "akhilank1937/first:latest" +" "+"/var/lib/jenkins/workspace/pipeline/Dockerfile"
		sh """ ls -ltr """
		sh """ cat anchore_images """
		anchore engineCredentialsId: 'anchore', engineurl: 'http://localhost:8228/v1/', name: 'anchore_images', engineverify: true,annotations: [[key: 'added-by', value: 'jenkins']], autoSubscribeTagUpdates: false, bailOnFail: false, engineRetries: '10000', forceAnalyze: true
    }
    }

    stage('Trufflehog'){
    		steps{
    			sh 'docker run --name truffle akhilank1937/first:latest --regex --entropy=False "https://github.com/Neoweed/pplscn" || true '
    			sh 'docker rm truffle || true'
    		}
	    }
	stage('Deploy and Dast'){
	parallel {
    stage('Deploy web application'){
    	steps{
    		sh 'mvn clean install || true'
    	}
    }

    stage('DAST') {
            steps {
                script {
                	sh 'docker pull owasp/zap2docker-stable'
                	sh 'sleep 30'
                    sh 'docker run -v /var/lib/jenkins/workspace/test1/:/zap/wrk/:rw -t owasp/zap2docker-stable zap-baseline.py -t "http://172.17.0.1:8080" -g gen.conf -r testreport.html || true'

                }
            }
        }
    }
    }

}
}
