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
