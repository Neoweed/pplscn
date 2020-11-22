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

    stage('Anchore on container scanning'){
    	parallel Test: {
app.inside {
sh 'echo "Dummy - tests passed"'
}
},
Analyze: {
writeFile file: anchorefile, text: "akhilank1937/first:latest" +" "+dockerfile 
sh """ ls -ltr """
sh """ cat anchore_images """
anchore name: anchorefile, engineurl:"https://localhost:8228/v1/"
engineCredentialsId: 'anchore', annotations: [[key:
'added-by', value: 'jenkins']] , autoSubscribeTagUpdates: false,
bailOnFail: false, engineRetries: '10000'
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
