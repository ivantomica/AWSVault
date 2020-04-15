<#
    .Synopsis
    Log-in into AWS Account with aws-vault utility and opet session in container tab

    .Description
    Log-in into AWS Account with aws-vault utility and opet session in container tab

    .Parameter ProfileName
    Name of the aws-vault profile

    .Example
    # Login to the AWS profile "example"
    Amazon-Web-Login example

    
#>

function Amazon-Web-Login {
    param(
        [parameter(Mandatory=$true)][string]$ProfileName
    )

    $aws_vault_login_stdout = (aws-vault login --stdout $ProfileName)
    $aws_vault_login_url = $aws_vault_login_stdout.replace("&", "%26")

    & "C:\Program Files\Mozilla Firefox\firefox.exe" "ext+container:name=$ProfileName&url=$aws_vault_login_url"
}

Export-ModuleMember -Function Amazon-Web-Login