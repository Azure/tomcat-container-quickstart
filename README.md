# Tomcat on Containers QuickStart

This repository contains artifacts to help you get started running Tomcat applications on Azure container platforms, such as the Azure Kubernetes Service (AKS). It is intended to accompany the [Tomcat to AKS Migration guide](https://docs.microsoft.com/azure/java/migrate-tomcat-to-containers-on-azure-kubernetes-service).

## Getting started

We provide a WAR build of [Spring Pet Clinic](https://github.com/spring-projects/spring-petclinic) in ROOT.war as a sample application. By following the steps below, you can see this QuickStart in action without the need to provide your own applciation or to make any modifications.

### Building and testing locally

If you have Docker CLI installed locally, you can build a docker image by running `docker build . -t quickstart` from the root of this repository.

You can then execute the image by typing `docker run -p8080:8080 -d quickstart`. Once the container is running, navigate to `http://localhost:8080` in [your favorite browser](https://www.microsoft.com/edge), and you should see the Petclinic application come up.

### Building and testing on Azure

Alternatively, you can build and test the image entirely on Azure. These steps can be performed from [Azure CloudShell](https://shell.azure.com) or from any machine with [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) installed.

1. [Create an Azure Container Registry](https://portal.azure.com/#create/Microsoft.ContainerRegistry). Be sure to enable the admin user.

1. Clone the repository and navigate into the root of the repository.

1. Once the Azure Container Registry instance is created, run the following command, where `${REGISTRY_NAME}` is the name of the Azure Container Registry you just created:

    ```bash
    az acr build -r ${REGISTRY_NAME} -t "${REGISTRY_NAME}.azurecr.io/quickstart" .
    ```

    The Azure Container Registry will now build the docker image on its own server.

1. Once the image build has completed, run the following command. It will deploy the image onto an Azure Container Instance. `${RESOURCE_GROUP}` should be the name of a resource group in your azure subscription. `${REGISTRY_NAME}` should be the same as above

    ```bash
    az container create -g ${RESOURCE_GROUP} -n ${REGISTRY_NAME} --image "${REGISTRY_NAME}.azurecr.io/quickstart"  \
        --registry-password "$(az acr credential show -n $REGISTRY_NAME --query "passwords[0].value" -o tsv)" \
        --registry-username "${REGISTRY_NAME}" --ip-address Public --ports 8080 \
        --query "ipAddress.ip"
    ```

    When the command completes, it will display an IP address. Navigate to `http://<The IP Address>:8080` in your browser, and you should see the home page of the deployed web application.

    To terminate the container instance, run

    ```bash
    az container delete -g ${RESOURCE_GROUP} -n ${REGISTRY_NAME} --yes
    ```

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
