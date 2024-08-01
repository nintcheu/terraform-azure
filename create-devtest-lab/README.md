# Create a lab in Azure DevTest Labs using Terraform

```
┌─────────────────────────────────────────────────────────────────────┐
│                       Azure Resource Group                          │
│  ┌───────────────────┐  ┌───────────────────┐  ┌───────────────────┐│
│  │   Random Pet      │  │   Random String   │  │  Random Password  ││
│  │    (rg_name)      │  │    (vm_suffix)    │  │    (password)     ││
│  └───────────────────┘  └───────────────────┘  └───────────────────┘│
│                │                  │                     │           │
│                │                  │                     │           │
│                ▼                  │                     │           │
│  ┌───────────────────────────┐    │                     │           │
│  │    Azure Resource Group   │    │                     │           │
│  │          (rg)             │    │                     │           │
│  └───────────────────────────┘    │                     │           │
│                │                  │                     │           │
│                │                  │                     │           │
│                ▼                  │                     │           │
│  ┌───────────────────────────┐    │                     │           │
│  │    Azure DevTest Lab      │    │                     │           │
│  │          (lab)            │    │                     │           │
│  └───────────────────────────┘    │                     │           │
│                │                  │                     │           │
│                │                  │                     │           │
│                ▼                  │                     │           │
│  ┌───────────────────────────┐    │                     │           │
│  │ Azure DevTest Virtual Net │    │                     │           │
│  │         (vnet)            │    │                     │           │
│  └───────────────────────────┘    │                     │           │
│                │                  │                     │           │
│                │                  │                     │           │
│                └──────────────────┼─────────────────────┘           │
│                                   │                                 │
│                                   ▼                                 │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │           Azure DevTest Windows Virtual Machine               │  │
│  │                           (vm)                                │  │
│  └───────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘
```

Explanation of the diagram:
- The outer box represents the Azure Resource Group that contains all resources.
- At the top, we have three random generators:
    - Random Pet for the resource group name
    - Random String for the VM suffix
    - Random Password (optional, used if no password is provided)
- The Azure Resource Group (rg) is created using the name from Random Pet.
- The Azure DevTest Lab (lab) is created within the resource group.
- The Azure DevTest Virtual Network (vnet) is created and associated with the lab.
- Finally, the Azure DevTest Windows Virtual Machine (vm) is created, which:
    - Uses the suffix from Random String
    - Is associated with the DevTest Lab
    - Uses the Virtual Network
    - Uses the password from either Random Password or the provided variable
The arrows indicate dependencies or relationships between resources. This diagram helps visualize how the different components of your Terraform configuration are related and the overall structure of your Azure resources.

```
┌─────────────────────┐
│   random_pet        │
├─────────────────────┤
│ id                  │
└─────────────────────┘
           │
           │ uses
           ▼
┌─────────────────────┐     ┌─────────────────────┐
│ azurerm_resource    │     │ random_string       │
│ _group              │     ├─────────────────────┤
├─────────────────────┤     │ result              │
│ name                │     └─────────────────────┘
│ location            │               │
└─────────────────────┘               │ uses
           │                          │
           │ references               │
           ▼                          │
┌─────────────────────┐               │
│ azurerm_dev_test    │               │
│ _lab                │               │
├─────────────────────┤               │
│ name                │               │
│ location            │               │
│ resource_group_name │               │
└─────────────────────┘               │
           │                          │
           │ references               │
           ▼                          │
┌─────────────────────┐               │
│ azurerm_dev_test    │               │
│ _virtual_network    │               │
├─────────────────────┤               │
│ name                │               │
│ lab_name            │               │
│ resource_group_name │               │
└─────────────────────┘               │
           │                          │
           │ references               │
           ▼                          ▼
┌─────────────────────────────────────────────────┐
│ azurerm_dev_test_windows_virtual_machine        │
├─────────────────────────────────────────────────┤
│ name                                            │
│ lab_name                                        │
│ lab_subnet_name                                 │
│ resource_group_name                             │
│ location                                        │
│ size                                            │
│ username                                        │
│ password                                        │
│ lab_virtual_network_id                          │
└─────────────────────────────────────────────────┘
                      ▲
                      │ uses
                      │
            ┌─────────────────────┐
            │ random_password     │
            ├─────────────────────┤
            │ result              │
            └─────────────────────┘
```

Explanation of the diagram:
- random_pet: Generates a random name for the resource group.
- azurerm_resource_group: Uses the name generated by random_pet.
- azurerm_dev_test_lab: References the resource group.
- azurerm_dev_test_virtual_network: References both the resource group and the dev test lab.
- random_string: Generates a random suffix for the VM name.
- random_password: Optionally generates a random password for the VM.
- azurerm_dev_test_windows_virtual_machine:
    - References the resource group, dev test lab, and virtual network.
    - Uses the random string for its name suffix.
    - Optionally uses the random password.
The arrows indicate dependencies or references between resources. This diagram helps visualize how the different components of your Terraform configuration are interconnected and depend on each other.