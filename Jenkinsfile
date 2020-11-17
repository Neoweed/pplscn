#!groovy
pipeline {
  agent any
  stages 
    {
    stage('SNYK') {
      steps {
        sh 'cd ${WORKSPACE}'
	sh 'echo "snyk test && snyk monitor" > snyk.sh'
	sh 'chmod +x snyk.sh'
	sh '/bin/bash snyk.sh || true'
	sh 'snyk test --json | snyk-to-html -o results.html'
      }
    }
