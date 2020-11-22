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
    stage('Configure') {
    abort = false
    inputConfig = input id: 'InputConfig', message: 'Docker registry and Anchore Engine configuration', parameters: [string(defaultValue: 'https://index.docker.io/v1/', description: 'URL of the docker registry for staging images before analysis', name: 'dockerRegistryUrl', trim: true), string(defaultValue: 'docker.io', description: 'Hostname of the docker registry', name: 'dockerRegistryHostname', trim: true), string(defaultValue: 'arunaav/anchore', description: 'Name of the docker repository', name: 'dockerRepository', trim: true), credentials(credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl', defaultValue: 'docker', description: 'Credentials for connecting to the docker registry', name: 'dockerCredentials', required: true), string(defaultValue: 'http://localhost:8228/v1/', description: 'Anchore Engine API endpoint', name: 'anchoreEngineUrl', trim: true), credentials(credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl', defaultValue: 'anchorecreds', description: 'Credentials for interacting with Anchore Engine', name: 'anchoreEngineCredentials', required: true)]

    for (config in inputConfig) {
        if (null == config.value || config.value.length() <= 0) {
          echo "${config.key} cannot be left blank"
          abort = true
        }
    }

    if (abort) {
        currentBuild.result = 'ABORTED'
        error('Aborting build due to invalid input')
    }
}
    stage('Anchore on container scanning'){
    	parallel Test: {
app.inside {
sh 'echo "Dummy - tests passed"'
}
},
Analyze: {
writeFile file: anchorefile, text:
inputConfig['dockerRegistryHostname'] + "/" + repotag + " " +
dockerfile
sh """ ls -ltr """
sh """ cat anchore_images """
anchore name: anchorefile, engineurl:
inputConfig['anchoreEngineUrl'], engineCredentialsId:
inputConfig['anchor Engine Credentials'], annotations: [[key:
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
