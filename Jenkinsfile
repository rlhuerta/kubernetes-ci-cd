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

   
 stage('Deploy Application') {
       
                   
           //Update the imagetag to the latest version
                   sh("sed -i.bak '127.0.0.1:30400/hello-kenzan:latest' ./k8s/development/*.yaml")
                   //Create or update resources
           sh("kubectl --namespace=${namespace} apply -f k8s/development/deployment.yaml")
                   sh("kubectl --namespace=${namespace} apply -f k8s/development/service.yaml")
           //Grab the external Ip address of the service
                   sh("echo http://`kubectl --namespace=${namespace} get service/${feSvcName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > ${feSvcName}")
                   break
}
 
}
