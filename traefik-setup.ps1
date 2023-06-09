#powershell

$KUBE_NAMESPACE = Read-Host -Prompt "Please enter namespace in file traefik-dashboard.yaml "
Write-Output "Traefik will install to $KUBE_NAMESPACE" 

kubectl create namespace $KUBE_NAMESPACE
kubectl config set-context --current --namespace=$KUBE_NAMESPACE

kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml #apply CRD define resource
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml #apply RBAC kubernetes define role for CRD

if ( -Not (Get-Command scoop -ErrorAction Ignore)) {
    $username = Read-Host -Prompt "Username "

    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    irm get.scoop.sh | iex 

    $env:Path -split ';' > $null
    $env:Path += ";C:\Users\$username\scoop\shims" > $null
}

if ( -Not (Get-Command helm -ErrorAction Ignore)) {
    scoop install helm
}

helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik

kubectl get svc -l app.kubernetes.io/name=traefik
kubectl get po -l app.kubernetes.io/name=traefik

$UserTraefik = Read-Host -Prompt "Username Traefik "

if ( -Not ("$UserTraefik" -eq '')) {
    bash -c "htpasswd -nB $UserTraefik | tee auth-secret"
    kubectl create secret generic -n $KUBE_NAMESPACE dashboard-auth-secret --from-file=users=auth-secret -o yaml --dry-run=client | tee dashboard-secret.yaml
    
    kubectl apply -f traefik-dashboard.yaml
    kubectl apply -f dashboard-secret.yaml

    rm auth-secret
    rm dashboard-secret.yaml

    $spinner = '/','-','\','|'
    $i = 0
    while ($true) {

        $status = Invoke-Expression -Command "kubectl get pods -l app.kubernetes.io/name=traefik --field-selector=status.phase=Running --ignore-not-found=true"
        if (-Not ("$status" -eq '')){
            Write-Host ""
            Write-Host ">>> Install Treafik dashboard Complete <<<" -ForegroundColor Green
            break
        }

        Write-Host -NoNewline "`r Installing Treafik dashboard ...$($spinner[$i])"
        $i = ($i + 1) % $spinner.Length
        Start-Sleep -Milliseconds 100
    }
    
}