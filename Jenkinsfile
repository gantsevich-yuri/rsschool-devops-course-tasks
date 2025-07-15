pipeline {
    agent any

    triggers {
        pollSCM('H/1 * * * *') 
    }

    stages {
         stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/gantsevich-yuri/rsschool-devops-course-tasks.git',
                    branch: 'task_6',
                    credentialsId: 'github-token'
                )
            }
        }

        stage('Hello') {
            steps {
                echo 'Hello Fox!'
            }
        }
    }
}
