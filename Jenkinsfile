pipeline {
    agent any

    triggers {
        pollSCM('H/1 * * * *') 
    }

    stages {
        stage('Hello') {
            steps {
                echo 'Hello from DevOps course!!!'
            }
        }
    }
}
