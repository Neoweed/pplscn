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
    stage('Build docker images') 
			{
      				steps {
        				sh 'docker build -t akhilank1937/first .'
      				      }
    			}

    stage('Push image') {
    	steps{
        withDockerRegistry([ credentialsId: "DockerHub", url: "" ]) {
         sh 'docker push akhilank1937/first:latest'
        }
    }
    }

    stage('Parallel'){
    	steps{

	  writeFile file: "anchore_images", text: "akhilank1937/first:latest" +" "+path11+"/Dockerfile"
sh """ ls -ltr """
sh """ cat anchore_images """
anchore engineCredentialsId: 'anchore', engineurl: 'https://localhost:8228/v1/', name: 'anchore_images', annotations: [[key: 'added-by', value: 'jenkins']] , autoSubscribeTagUpdates: false, bailOnFail: false, engineRetries: '10000'
    }
    }
    stage('Execute in Jenkins'){
    		steps{
    			sh 'docker run --name truffle akhilank1937/first:latest --regex --entropy=False "https://github.com/Neoweed/pplscn" || true '
    			sh 'docker rm truffle || true'
    		}
    }


}
}
