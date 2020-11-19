#!groovy

pipeline {
  agent any
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

    stage('Execute in Jenkins'){
    		steps{
    			sh 'docker run --name truffle akhilank1937/first:latest --regex --entropy=False "https://github.com/Neoweed/pplscn"'
    		}
    }
}
}
