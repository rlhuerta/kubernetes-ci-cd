node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "hello-kenzan"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appName}:latest"
    env.BUILDIMG=imageName

    stage "Build"
    
        sh "docker build -t ${imageName} -f /home/rthuerta/kubernetes-ci-cd/applications/hello-kenzan/Dockerfile /home/rthuerta/kubernetes-ci-cd/applications/hello-kenzan"
    
    stage "Push"

        sh "docker push ${imageName}"

   
    stage "Deploy"
       
     sh "kubectl apply -f /home/rthuerta/kubernetes-ci-cd/applications/hello-kenzan/k8s/manual-deployment.yaml"

 
}
