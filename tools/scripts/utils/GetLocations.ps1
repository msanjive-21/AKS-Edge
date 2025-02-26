# List of locations derived using the following command - 
<# Azure Regions where Arc enabled Kubernetes is supported.
    $data = (az provider show --namespace "Microsoft.Kubernetes" --output json) | ConvertFrom-Json
    $resourceInfo = $data.resourceTypes | Where-Object { $_.resourceType -eq "connectedclusters" } # lists the displaynames
    $arcLocations = $resourceInfo.locations.toLower().replace(" ","") # gives the locations unsorted.
    $arcLocations = $arcLocations | Sort-Object # Sort the list.
    #Mapping of names to displaynames : az account list-locations -o table
#>
New-Variable -Option Constant -ErrorAction SilentlyContinue -Name arcLocations -Value @(
    "australiaeast","brazilsouth","canadacentral","canadaeast","centralindia","centralus","centraluseuap",
    "eastasia","eastus","eastus2","eastus2euap","francecentral","germanywestcentral","israelcentral",
    "italynorth","japaneast","koreacentral","northcentralus","northeurope","norwayeast","southafricanorth",
    "southcentralus","southeastasia","southindia","swedencentral","switzerlandnorth","uaenorth","uksouth",
    "ukwest","westcentralus","westeurope","westus","westus2","westus3"
)

function  Get-ArcSupportedLocations {
    return $arcLocations
}

function Get-IsSupportedLocation {
    param(
        [Parameter(Mandatory)]
        [String] $Location
    )

    if ($arcLocations -inotcontains $Location) {
        return $false
    }
    return $true 
}