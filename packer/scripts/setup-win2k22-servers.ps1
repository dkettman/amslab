Write-Host "Installing OpenSSH Client"
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0;

Write-Host "Waiting 5 seconds before we install OpenSSH Server. Windows gets grumpy otherwise."
Start-Sleep -Seconds 5

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0;

Write-Host "Starting SSHD"
Start-Service sshd;

Write-Host "Setting SSHD to start at boot"
Set-Service -Name sshd -StartupType 'Automatic';


Write-Host "Downloading and placing SSH keys where they belong."
$ssh_pub_keys = (curl https://github.com/dkettman.keys -UseBasicParsing)
$ssh_pub_keys | Out-File -FilePath c:\programdata\ssh\administrators_authorized_keys -Append -Force

$ansible_ssh_keys = New-Item -ItemType Directory -Path C:\Users\Ansible\.ssh -Force | Out-Null
$ssh_pub_keys | Out-File -FilePath $ansible_ssh_keys.FullName -Force
