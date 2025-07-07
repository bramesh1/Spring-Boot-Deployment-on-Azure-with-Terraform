# Spring Boot Web App Deployment on Azure

## **Application URL**

The Spring Boot application is successfully deployed and can be accessed at:\
🔗 [Spring Boot Web App](https://springboot-webapp-107f5672ade1e2b7.azurewebsites.net/)

---

## Project Overview

This repository contains a Spring Boot web application that has been successfully deployed to Azure App Service using Infrastructure as Code (IaC) principles with Terraform.

## Deployment Workflow

Our deployment workflow follows these key steps: 

1. **Local Development & Testing**
   - Developed the Spring Boot application locally
   - Ran thorough testing to ensure functionality
   - Runs `mvn clean package` to generate the `.jar` file

2. **Source Control**
   - Maintained code in this Git repository
   - Implemented branching strategy for feature development and releases

3. **Infrastructure as Code**
   - Used Terraform to define all Azure resources
   - Stored Terraform configuration in the `/terraform` directory
   - Applied infrastructure changes through CI/CD pipeline

4. **Continuous Integration/Continuous Deployment**
   - Implemented GitHub Actions workflow
   - Automated testing, building, and deployment processes
   - Uses `azure/webapps-deploy@v2` action to deploy the packaged `.jar` file.
   - The workflow is triggered on a push to the `main` branch.

**GitHub Actions Workflow Snippet**:

```yaml
name: Deploy to Azure Web App

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Java 17
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: Build the application
        run: mvn clean package

      - name: Retrieve webapp_name from Terraform
        run: |
          echo "Retrieving webapp_name from Terraform..."
          APP_NAME=$(terraform -chdir=terraform output -raw webapp_name | tr -d '\r')
          if [[ -z "$APP_NAME" ]]; then
            echo "Error: webapp_name is empty!"
            exit 1
          fi
          echo "Deploying to $APP_NAME"
          echo "app_name=$APP_NAME" >> $GITHUB_ENV

      - name: Deploy to Azure Web App
        uses: azure/webapps-deploy@v2
        with:
          app-name: ${{ env.app_name }}
          package: demo/target/demo-0.0.1-SNAPSHOT.jar
```

---

## **Terraform Configuration**

The Terraform script provisions an **Azure Web App** and other necessary resources.

**Terraform Configuration Snippet (**\`\`**)**:

```hcl
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

resource "random_id" "app_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = "springboot-rg"
  location = "westeurope"
}

resource "azurerm_service_plan" "asp" {
  name                = "springboot-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.app_service_name}-${random_id.app_name.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = false
    application_stack {
      java_version        = "17"
      java_server         = "JAVA"
      java_server_version = "17"
    }
  }
}
```
---

## **Challenges Encountered & Solutions**

### **1. Terraform Output Parsing Issue**

- **Issue**: The retrieved `webapp_name` included unexpected debug output, causing deployment failure.
- **Solution**: Used `tr -d '\r'` to clean Terraform output before using it in GitHub Actions.

### **2. Missing Azure Credentials in GitHub Secrets**

- **Issue**: Deployment failed due to missing credentials (`AZURE_CREDENTIALS`).
- **Solution**: Added **service principal credentials** in `AZURE_CREDENTIALS` under GitHub secrets.

### **3. Deployment Pipeline Permissions**

- **Issue**: GitHub Actions workflow required proper permissions to deploy to Azure.
- **Solution**: Created a Service Principal with limited scope permissions and stored credentials as GitHub repository secrets.

---

## **Future Improvements**

- Monitor logs in **Azure Portal** (`App Service > Log Stream`).
- Implement staging/production environments with slots for zero-downtime deployments
- Add automated database migrations
- Enhance monitoring with custom dashboards and additional metrics
- Implement infrastructure for scaling based on demand

---

## Getting Started

To work with this project locally:

1. Clone the repository
2. Install prerequisites:
   - Java 17
   - Maven
   - Terraform
   - Azure CLI
3. Run the application locally:
   ```bash
   mvn spring-boot:run
   ```
4. To deploy infrastructure changes:
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

**Author**: Bhumika Ramesh\
📅 **Date**: March 2025