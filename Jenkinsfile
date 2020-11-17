#!groovy
pipeline {
  agent any
  stages 
    {
    stage('SNYK') {
      steps {
        	snykSecurity failOnIssues: false, snykInstallation: 'Please define a Snyk installation in the Jenkins Global Tool Configuration. This task will not run without a Snyk installation.', snykTokenId: 'snyk'
		}
}
}
}
