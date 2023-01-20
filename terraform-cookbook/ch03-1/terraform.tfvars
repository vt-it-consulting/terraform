nb_webapp           = 2
resource_group_name = "Terraform-RG"
service_plan_name   = "Terraform-Service-Plan"
environment         = "DEV"


tags = {
  ENV          = "DEV1"
  CODE_PROJECT = "DEMO"
}
app_settings = {
  KEY1 = "VAL1"
}

custom_app_settings = {
  CUSTOM_KEY1 = "CUSTOM_VAL1"
}

web_apps = {
  webapp1 = {
    "name"                     = "webappdemobook1"
    "location"                 = "West Europe"
    "dotnet_framework_version" = "v4.0"
    "serverdatabase_name"      = "server1"
  },
  webapp2 = {
    "name"                     = "webapptestbook2"
    "dotnet_framework_version" = "v4.0"
    "serverdatabase_name"      = "server2"
  }
}


ngs_rules = [
  {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "rule"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
