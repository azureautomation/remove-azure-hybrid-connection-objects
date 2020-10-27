# Login to Azure
Login-AzureRmAccount

# Select a specific subscription for the context
Get-AzureRmSubscription | Out-GridView -PassThru -Title 'Select Subscription' | Select-AzureRmSubscription

# Get all the Hybrid Connections from all namespaces in all resource groups
$hybridConnections = Get-AzureRmResource -ResourceType Microsoft.Relay/namespaces | ForEach-Object {
    $resourceGroupName = $_.ResourceGroupName
    Get-AzureRmRelayHybridConnection -ResourceGroupName $resourceGroupName -Namespace $namespace.Name | ForEach-Object {
        $resourceName = '{0}/{1}' -f ($_.Id -split '/')[-3,-1]
        Get-AzureRmResource -ResourceGroupName $resourceGroupName -ResourceType Microsoft.Relay/Namespaces/HybridConnections `
            -ApiVersion 2016-07-01 -ResourceName $resourceName | Select-Object @{N='ResourceGroupName';E={$resourceGroupName}},
                @{N='ResourceName';E={$resourceName}},
                @{N='CreatedAt';E={$_.Properties.createdAt}},
                @{N='UpdatedAt';E={$_.Properties.updatedAt}},
                @{N='ListenerCount';E={$_.Properties.listenerCount}},
                @{N='UserMetadata';E={$_.Properties.userMetadata}}
    }
}

# Ask which connection to delete
$hybridConnections | Out-GridView -PassThru -Title 'Select the Hybrid Connections you want to delete' | ForEach-Object { 
    Remove-AzureRmResource -ResourceGroupName $resourceGroupName -ResourceType Microsoft.Relay/Namespaces/HybridConnections `
        -ApiVersion 2016-07-01 -ResourceName $_.ResourceName -Force 
}