[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/FsgXT19_)
[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=18340494)
# HW3: Continuous Delivery Pipeline of Web Application
- SE441: Continuous Delivery and DevOps
- Winter 2025
- Due: Thursday, February 27, 2025 at 5:30PM
- Grade: 10% of final grade

## Objective
Deploy a web application to Microsoft Azure using Terraform for infrastructure provisioning and GitHub
Actions for continuous delivery. This assignment will enhance your skills in cloud computing, Infrastructure
as Code (IaC), continuous integration (CI), and continuous delivery (CD).

## Steps

### Create an Azure Account
Create a Microsoft Azure account if you don’t have one already. You can either use Azure for Students
(information at https://azure.microsoft.com/en-us/free/students) or the Azure free tier.

### Accept the Assignment
Similar to Assignments 1 and 2, follow the typical steps to accept the assignment in GitHub.

Please perform all your work in a separate Git branch. The act of merging this branch to main will
trigger the submission of your assignment.

### Create a Web Application
Either develop or download a simple web application in your language/framework of choice. The application’s
functionality is unimportant — it could do something as simple as outputting “Hello world”.

This web application will be deployed on Azure using the Azure service of your choice. For example, you
could choose [Azure Static Web Apps][1], [Azure Web App Service][2], [Azure Container App Service][3],
[Azure Kubernetes Service (AKS)][4], or [Azure Functions][5]. If you’re not sure which service to choose,
I suggest performing independent research up front to see which one is easiest.

### Infrastructure as Code with Terraform
1. **Install Terraform**: Ensure Terraform is installed on your local machine.
2. **Create Terraform Configuration**: Write a Terraform configuration to provision the necessary Azure
resources to contain your application.
3. **Store Azure Credentials Securely**: Store your Azure credentials securely using GitHub Secrets to
be used by GitHub Actions and Terraform.
4. **Commit Terraform Configuration**: Commit your Terraform files to the GitHub repository in a
separate directory (e.g., `/terraform`).

### Continuous Delivery with GitHub Actions
1. Set Up GitHub Actions Workflow: Create a new GitHub Actions workflow in the `.github/workflows`
   directory, named `azure-cd.yml`.
2. Workflow Steps: Configure the workflow to trigger on pushes to the main branch. It should:
    - Checkout the repository.
    - Set up Terraform and initialize the Terraform configuration.
    - Apply the Terraform configuration to provision/update the Azure infrastructure.
    - Deploy the web application to Azure App Service using the Azure CLI or another method,
      authenticating with credentials stored in GitHub Secrets.
3. Test the Pipeline: Push a change to your application to trigger the GitHub Actions workflow. Monitor
   the workflow to ensure the infrastructure is provisioned and the application is deployed successfully.

### Documentation and Submission
Submit the following:
    - The source code to your GitHub repository merged to main.
    - A brief report documenting the URL to your deployed application on Azure, your workflow,
      Terraform configuration, and any challenges encountered as a `README.md` file in your repository.

## Evaluation Criteria
1. Functionality of the web application (20%)
2. Correct implementation and application of Terraform for infrastructure provisioning (30%).
3. Successful continuous delivery and operation of the application (30%).
4. Documentation, code cleanliness, and best practices adherence (20%).

## Additional Resources
- [Terraform Tutorial][6]
- [Terraform on Azure Documentation][7]
- [Azure App Service documentation][8]
- [Quickstart: Deploy a Python (Django or Flask) web app to Azure App Service][9]

[1]: https://azure.microsoft.com/en-us/products/app-service/static
[2]: https://azure.microsoft.com/en-us/products/app-service/web
[3]: https://azure.microsoft.com/en-us/products/container-apps
[4]: https://azure.microsoft.com/en-us/products/kubernetes-service
[5]: https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview?pivots=programming-language-csharp
[6]: https://developer.hashicorp.com/terraform/tutorials
[7]: https://learn.microsoft.com/en-us/azure/developer/terraform/
[8]: https://learn.microsoft.com/en-us/azure/app-service/
[9]: https://learn.microsoft.com/en-us/azure/app-service/quickstart-python