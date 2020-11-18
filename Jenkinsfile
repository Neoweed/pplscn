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
				withDockerRegistry(credentialsId: 'DockerHub', url:"")
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
			           jobId: "1394a8a5-2738-451a-b082-e589c4f77cd3",
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
