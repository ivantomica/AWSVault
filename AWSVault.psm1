function New-AWSSession {
    param (
        [parameter(Mandatory=$true)][string]$ProfileName
    )

    $script:AWSLoginURL = (aws-vault login --stdout $ProfileName)
}

<#
    .Synopsis
    Log-in into AWS Account with aws-vault utility and opet session in container tab

    .Description
    Log-in into AWS Account with aws-vault utility and opet session in container tab

    .Parameter ProfileName
    Name of the aws-vault profile

    .Parameter FirefoxContainer
    Switch parameter to use Firefox Container feature.
    Usage requires following extension: https://addons.mozilla.org/en-US/firefox/addon/open-url-in-container/

    .Parameter FirefoxContainerName
    By default container name is the same as specified ProfileName. With this switch you can override the name of the container.

    .Example
    # Login to the AWS profile "example"
    Open-AWSSession example
#>
function Open-AWSSession {
    param(
        [parameter(Mandatory=$true)][string]$ProfileName,
        [switch]$FirefoxContainer,
        [string]$FirefoxContainerName = $ProfileName
    )

    New-AWSSession -ProfileName $ProfileName

    if ($FirefoxContainer -eq $true) {
        $EscapedAWSLoginURL = $AWSLoginURL.Replace("&", "%26")
        & "C:\Program Files\Mozilla Firefox\firefox.exe" "ext+container:name=$FirefoxContainerName&url=$EscapedAWSLoginURL"
    }
    else {
        Start-Process -FilePath "$AWSLoginURL"
    }
}

Export-ModuleMember -Function Open-AWSSession
