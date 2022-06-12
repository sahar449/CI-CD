This project is:
Build infrastructure in aws, via Terraform.
After that create a Jenkinsfile that:
build java code -> push him to nexus -> after that via ansible download the artifact and send him to another server on docker contianer.
