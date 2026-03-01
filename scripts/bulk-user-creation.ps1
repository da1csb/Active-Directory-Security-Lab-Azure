# ==============================
# Active Directory User Factory
# ==============================

Import-Module ActiveDirectory

# ---- Settings ----
$Password = ConvertTo-SecureString "CyberSecurity123!" -AsPlainText -Force
$OUs = @("IT", "Sales", "Admin")
$DomainPath = "DC=SecEng,DC=local"

Write-Host "--- INITIALIZING MASS PROVISIONING ---" -ForegroundColor Cyan

# ---- Create 1000 Users ----
for ($i = 1; $i -le 1000; $i++) {

    $Username = "User$i"
    $SelectedOU = $OUs | Get-Random

    # Construct OU Distinguished Name
    $OUPath = "OU=$SelectedOU,$DomainPath"

    New-ADUser `
        -Name $Username `
        -SamAccountName $Username `
        -UserPrincipalName "$Username@SecEng.local" `
        -Path $OUPath `
        -AccountPassword $Password `
        -Enabled $true `
        -ChangePasswordAtLogon $false
}

Write-Host "User provisioning completed successfully." -ForegroundColor Green
