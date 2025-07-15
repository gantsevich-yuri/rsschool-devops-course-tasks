pipeline {
    agent any

    triggers {
        pollSCM('H/1 * * * *') 
    }

    stage('Checkout') {
    steps {
        git(
            url: 'https://github.com/gantsevich-yuri/rsschool-devops-course-tasks.git',
            credentialsId: 'github-token'
        )
    }
}

    stages {
        stage('Hello') {
            steps {
                echo 'Hello from DevOps course!!!'
            }
        }
    }
}
