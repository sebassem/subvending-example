# Code samples

## Using Azure CLI and a parameters file

```bicep
az deployment mg create --template-file ./main.bicep --parameters ./main.bicepparam --location <location> --management-group-id <ID of the management group to deploy this template not where the subscription will be associated>
```

## Using Azure Powershell

```Powershell
$inputObject = @{
              DeploymentName        = 'pr-lz-vend-{0}' -f (-join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
              ManagementGroupId     = "<ID of the management group to deploy this template not where the subscription will be associated>"
              Location              = "<location>"
              TemplateFile          = "./main.bicep"
              TemplateParameterFile = "./main.bicepparam"
            }

New-AzManagementGroupDeployment @inputObject -Whatif
```