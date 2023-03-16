# Kubernetes
### Step on Work
1. Install tools Kubernetes

    <details>
    <summary>kubectl</summary>

    - Ref
      - https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/

    - download Kubectl.exe to path want

      ```
      curl.exe -LO "https://dl.k8s.io/release/v1.26.0/bin/windows/amd64/kubectl.exe"
      ```
      
    - Add Path to environment variable

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

    </details>
    
    <details>
    <summary>minikube</summary>

    - Ref
      - https://minikube.sigs.k8s.io/docs/start/

    - download minikube.exe
      ```ruby
      New-Item -Path 'c:<path want to install>' -Name 'minikube' -ItemType Directory -Force #create folder minikube
      Invoke-WebRequest -OutFile 'c:<path want to install>\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing #download install to path
      ```

    - Add Path to environment variable run Admin
      ```ruby
      $oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
      if ($oldPath.Split(';') -inotcontains 'C:<path folder minikube.exe>'){ `
      [Environment]::SetEnvironmentVariable('Path', $('{0};C:<path folder minikube.exe>' -f $oldPath), [EnvironmentVariableTarget]::Machine) `
      }
      ```
    - Restart Terminal

    </details>

    <details>
    <summary>Docker engine</summary>
    - Install Linux Ubuntu on windown
    - Install Docker Desktop
      - https://www.docker.com/products/docker-desktop/

    </details>

2. Config cluster Kubernetes
   - Ref 
     - https://minikube.sigs.k8s.io/docs/drivers/docker/

   - Create/Start Cluster minikube in docker on Command Prompt
     ```
     minikube start --driver=docker
     ```

   - Check pods cluster
     ```
     kubectl get pods -A
     ```
  
   - Check nodes 
     ```
     kubectl get nodes
     ```
   
   - Open Dashboard minikube
     ```
     minikube dashboard #open addon
     ```

   - Set Loadbalance
     ```
     minikube tunnel
     ```
3. Install Traefik
   - Ref
     - 
     - https://github.com/iamapinan/kubeplay-traefik

   - Create traefik-setup.ps1
     <details>
     <summary>Show code</summary>

     ```
     ```

     </details>

   - Create file traefik-dashboard.yml
     ```ruby
     ```

   - run file traefik-setup.ps1
     ```
     ./traefik-setup.ps1
     ```

   - Deploy traefik-dashboard.yml
   - Get detail traefik show ip
     ```
     kubectl get svc #look at EXTERNAL-IP
     ```

   - Set Domain in file host in path windows
     ```ruby
     C:\Windows\System32\drivers\etc\hosts # ex. EXTERNAL-IP traefik.spcn19.local
     ```

   - Test Open Traefik dashboard
     ```
     traefik.spcn19.local
     ```

### Command 
 - Ref 
   - https://minikube.sigs.k8s.io/docs/start/

### LINK on Local
 - traefik.spcn19.local
 - web.spcn19.local 

