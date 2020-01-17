# Tomcat on Containers QuickStart

This repository contains artifacts to help you get started running Tomcat applications on Azure container platforms, such as the Azure Kubernetes Service (AKS). It is intended to accompany the [Tomcat to AKS Migration guide](https://docs.microsoft.com/azure/java/migrate-tomcat-to-containers-on-azure-kubernetes-service).

## Getting started

If you have Docker CLI installed locally, you can build a docker image by running `docker build . -t quickstart` from the root of this repository.

You can then execute the image by typing `docker run -p8080:8080 -d quickstart'. Once the container is running, navigate to `http://localhost:8080` in [your favorite browser](https://www.microsoft.com/edge), and you should see a startup page.

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
