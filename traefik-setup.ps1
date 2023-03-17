#powershell

$KUBE_NAMESPACE = Read-Host -Prompt "Please enter you namespace " #Enter name space
Write-Output "Traefik will install to $KUBE_NAMESPACE" 

kubectl create namespace $KUBE_NAMESPACE #create namespace on cluster
kubectl config set-context --current --namespace=$KUBE_NAMESPACE #set config on kube defalt namespace
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml #apply CRD define resource
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml #apply RBAC kubernetes define role for CRD

if ( -Not (Get-Command scoop -ErrorAction Ignore)) { #check scoop already
    #install scoop
    $username = Read-Host -Prompt "Username " #Read Username computer
    irm get.scoop.sh | iex #install scoop
    $env:Path -split ';' #define environment
    $env:Path += ";C:\Users\$username\scoop\shims" #define environment
}

if ( -Not (Get-Command helm -ErrorAction Ignore)) { #check helm already
    #install helm
    scoop install helm
}

helm repo add traefik https://traefik.github.io/charts # add repo traefik charts is traefik in helm
helm repo update # update repo to make prepare install traefik charts
helm install traefik traefik/traefik # Install traefik chart to make loadbalance and reverse Proxy 

kubectl get svc -l app.kubernetes.io/name=traefik #Get service label name app.kubernetes.io/ name = traefik
kubectl get po -l app.kubernetes.io/name=traefik #Get pod label name app.kubernetes.io/ name = traefik

$UserTraefik = Read-Host -Prompt "Username Traefik " #Enter Username Login Traefik

if ( -Not ("$UserTraefik" -eq " ")) { #Check emply value
    bash -c "htpasswd -nB $UserTraefik | tee auth-secret" #Create password to hash
    bash -c "kubectl create secret generic -n traefik dashboard-auth-secret --from-file=users=auth-secret -o yaml --dry-run=client | tee dashboard-secret.yaml" #Genarate secure password to users and create file dashboard-secret.yaml
}