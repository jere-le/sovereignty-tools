//This snippet ensures that any storage account deployed through this module is locked to TLS 1.2 and disables public network access, forcing the use of Private Endpoints as mentioned in your "What good looks like" slide.


resource storageAccount 'Microsoft.Storage/storageaccounts@2023-01-01' = {
  name: 'stsovereignprod001'
  location: resourceGroup().location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    // The "Insulation": Essential for Sovereignty
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Disabled' 
    
    // Key Management: Customer-Managed Key (CMK) ready
    encryption: {
      services: {
        blob: { enabled: true }
        file: { enabled: true }
      }
      keySource: 'Microsoft.KeyVault' // Change to 'Microsoft.Storage' for platform-managed
    }
  }
}
