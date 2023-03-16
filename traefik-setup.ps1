#windows

$KUBE_NAMESPACE = Read-Host -Prompt "Please enter you namespace "
Write-Output "Traefik will install to $KUBE_NAMESPACE"

kubectl create namespace $KUBE_NAMESPACE
kubectl config set-context --current --namespace=$KUBE_NAMESPACE
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml

if ( -Not (Get-Command scoop -ErrorAction Ignore)) {
    #install scoop
    $username = Read-Host -Prompt "Username "
    # Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    irm get.scoop.sh | iex
    $env:Path -split ';'
    $env:Path += ";C:\Users\$username\scoop\shims"
}

if ( -Not (Get-Command helm -ErrorAction Ignore)) {
    #install helm
    scoop install helm
}

helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik

kubectl get svc -l app.kubernetes.io/name=traefik
kubectl get po -l app.kubernetes.io/name=traefik 

$confirm = Read-Host -Prompt "Confirm (Y/N) "

if ("$confirm" -eq "Y") {
    bash -c "htpasswd -nB user | tee auth-secret"
    bash -c "kubectl create secret generic -n traefik dashboard-auth-secret \
    --from-file=users=auth-secret -o yaml --dry-run=client | tee dashboard-secret.yaml"
}

