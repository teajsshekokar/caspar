# Caspar App

Tried to keep things simple as much as possible. Implemented the skeleton for the solution. There still few imporoment needed that been highlited in the Assumptions sections.


Project structure  
```text
|-- .github
|   `-- workflows
|       `-- github-workflow.yaml
|-- README.md
|-- app
|   |-- docker
|   |   `-- Dockerfile
|   |-- main.py
|   `-- requirements.txt
`-- infra
    |-- kubernetes
    |   `-- caspar-app.yaml
    `-- terraform
        |-- files
        |   `-- user_data.sh
        `-- main.tf

```

Project has devided into three parts  
-- `app` - Python applicaiton that connects with Redis and PostgresDB, also contains Dockerfile.  
-- `infra` - contains Terraform IaC and Kubernetes manifest for application.  
-- `.github` - CI/CD using github actions.  Deploying EC2 instance and using same as github self-hosted runner for build and deploy.  


<hr></hr>  

### Assumptions

-- PostgresDB and Redis would be already installed in the same namespace where app is installed with default credentials.
-- Postgres K8s Service Name - postgres-svc  
-- Redis Service Name - redis-svc
-- if not then both can be installed simply using helm.  

---


### CI/CD Approach 

EC2 instance would be pre-packed with `minikube`  and required binaries, and will be used as `self-hosted` runnner.
There are three jobs  
-- `build` - To build image  
-- `deploy` - to deploy kubernetes objects service and deployment    
-- `patch_deployment` - to update the deployment image

Flow -  
I was hoping Gitlab Action to have feature run the job as variable provided. This feature is available in the Gitlab according tried to implement the same in this pipeline as well. For now Each job will trigger manually if we provide variable
- `build_image: true`: it triggers build job
- `deploy_app: true`: It triggers deploy job and manifest file's objects would be deployed to kubernetes cluster.  
- `patch_deployment: true, image_tag: tag_value` - it triggers patch_deployment job and update the deployment image