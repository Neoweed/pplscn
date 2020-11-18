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
        				sh 'docker build -t truffle/mytag2 .'
      				      }
    			}

    stage("push")
			{
				steps
				{
					withDockerRegistry(credentialsId: 'DockerHub', url:"https://index.docker.io/v1/")
					{
						sh 'docker push truffle/mytag2:latest'
					}
				}
			}
    stage('Execute Rundeck job') {
			      steps {
			 	 script {
			 	   step([$class: "RundeckNotifier",
  			           includeRundeckLogs: true,
			           jobId: "98e4bcee-662a-4346-9fbe-75928559a921",
        			   rundeckInstance: "rundeck",
          			   shouldFailTheBuild: true,
          			   shouldWaitForRundeckJob: true,
          			   tags: "",
          			   tailLog: true])
					}
				     }
							}
    }
	 }
