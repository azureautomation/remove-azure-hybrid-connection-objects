Remove Azure Hybrid Connection objects
======================================

            

There is currently no cmdlet to easily remove an Azure Hybrid Connection object (from an App Service Plan).



So in a case you need to remove several connection objects, doing it from the protal is tedious.



This is why I created this script.


It helps you Login into Azure, select the relevant subscription, and then the code iterates all the resource groups to get all the hybrid connection objects.



 


Then you'll get a grid view where you can select the hybrid connection objects you want to delete.


 



PowerShell
Edit|Remove
powershell
# Login to Azure	
Login-AzureRmAccount	

# Select a specific subscription for the context
Get-AzureRmSubscription | 
    Out-GridView -PassThru -Title 'Select Subscription' |
        Select-AzureRmSubscription

# …
# …

# Ask which connection to delete	
$hybridConnections |
   Out-GridView -PassThru -Title 'Select the Hybrid Connections you want to delete' | 
      ForEach-Object {
 	    Remove-AzureRmResource `
 	    ResourceGroupName $resourceGroupName `
 	    -ResourceType Microsoft.Relay/Namespaces/HybridConnections `
 	    -ApiVersion 2016-07-01 `
 	    -ResourceName $_.ResourceName -Force 	
}


# Login to Azure     
Login-AzureRmAccount     
 
# Select a specific subscription for the context 
Get-AzureRmSubscription |  
    Out-GridView -PassThru -Title 'Select Subscription' | 
        Select-AzureRmSubscription 
 
# … 
# … 
 
# Ask which connection to delete     
$hybridConnections | 
   Out-GridView -PassThru -Title 'Select the Hybrid Connections you want to delete' |  
      ForEach-Object { 
         Remove-AzureRmResource ` 
         ResourceGroupName $resourceGroupName ` 
         -ResourceType Microsoft.Relay/Namespaces/HybridConnections ` 
         -ApiVersion 2016-07-01 ` 
         -ResourceName $_.ResourceName -Force      
} 





        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
