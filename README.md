# Kubernetes
### Step on Work
1. Install tools Kubernetes
   - kubectl on windows
     - Ref
       - https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/

     - download Kubectl.exe to path work /Kube/kubectl

       ```
       curl.exe -LO "https://dl.k8s.io/release/v1.26.0/bin/windows/amd64/kubectl.exe"
       ```
       
     - add Path to environment variable

       - Search environment
    
         ![](image/environment.png)

       - Click Environment Variables...

         ![](image/clickEnVa.png)

       - Select Path Click Edit

         ![](image/selectPath.png)

       - Click New
         
         ![](image/listPath.png)

       - Add Path that have kubectl.exe
       - Click OK
    
     - Test Kubectl enable 
       ```
       kubectl version --client
       ```

   - minikube
     - Ref
       - https://minikube.sigs.k8s.io/docs/start/
     - download minikube.exe
       ```
       New-Item -Path 'c:<path want to install>' -Name 'minikube' -ItemType Directory -Force #create folder minikube
       Invoke-WebRequest -OutFile 'c:<path want to install>\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing #download install to path
       ```
   - docker engine