#!groovy

pipeline {
  agent any
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


    stage('Parallel'){
    	steps{

	  writeFile file: "anchore_images1", text: "akhilank1937/first:latest" +" "+"/var/lib/jenkins/workspace/pipeline/Dockerfile"
sh """ ls -ltr """
sh """ cat anchore_images """
anchore engineCredentialsId: 'anchore', engineurl: 'http://localhost:8228/v1/', name: 'anchore_images1', engineverify: true, annotations: [[key: 'added-by', value: 'jenkins']] , autoSubscribeTagUpdates: false, bailOnFail: false, engineRetries: '10000'
    }
    }
    stage('Trufflehog'){
    		steps{
    			sh 'docker run --name truffle akhilank1937/first:latest --regex --entropy=False "https://github.com/Neoweed/pplscn" || true '
    			sh 'docker rm truffle || true'
    		}
    }

    stage('Deply web application'){
    	steps{
    		sh 'mvn clean install || true'
    	}
    }

}
}
