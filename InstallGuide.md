# Technical Overview

This webapp for Carrie's Closet of Georgia runs using [Ruby on Rails](https://rubyonrails.org/), a full-stack framework for [CRUD web apps](https://www.codecademy.com/articles/what-is-crud). The best resource for learning about and debugging common Rails problems is the [official Rails guide](https://guides.rubyonrails.org/), which were used extensively during development. Rails beleives in "convention over configuration," so many features needed came out of the box. Many also come from packages, which Rails calls Gems. Notable Gems used by this webapp include: `devise`, `devise-invitable`, `webpakcer`, and `puma`. Gems can suffer from the [bloated dependency problem](https://res.cloudinary.com/practicaldev/image/fetch/s--hHU5ov3u--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://preview.redd.it/eu7hrdzzy3x11.jpg%3Fwidth%3D640%26crop%3Dsmart%26auto%3Dwebp%26s%3D18ed21e9420e1b0fb327c3d356f0c47eb28f9aa2), so tread carefully when adding new ones.

The app is deployed on Google Cloud using their managed [Kubernetes](https://kubernetes.io/) platform, [Google Cloud Run](https://cloud.google.com/run). The binaries are packaged into a [Docker](https://docs.docker.com/get-started/overview/) container, which Google scales automagically based on request intensity. Current configuration allows Google to shut down all container instances when not in use, which means Carrie's Closet gets around 1.2 million free monthly requests (although first requests in more than an hour can be slow). Postgres is used for the database, which is also hosted with Google Cloud, and is currently the only hosting cost. For details on how to deploy to these services, continue reading.

# Local Installation (for testing/development)

See [README.md](README.md)

# Production Instance

Production app goes on Google Cloud.

### Pre-requisites
1. A Google Cloud account
2. A project on Google Cloud with billing enabled, as well as the Cloud Run API, Cloud SQL API, and Google Contiainer Registry enabled

### Dependent libraries that must be installed:
1. [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. [Git](https://git-scm.com/downloads)
3. [Google Cloud CLI](https://cloud.google.com/sdk) (Command Line Interface)

### Download instructions: 
Clone the repository (it's open source) by runing in your shell: 

```$ git clone https://github.com/tumbleshack/CarriesCloset.git```

### Build instructions (if needed)
Prepare your environment by setting your Google Cloud project id
```
export PROJECT_ID=your-project-id
```
Create a name for your cloud run service, we suggest
```
export _SERVICE_ID=carries-closet-webapp
```
Build the container by running
```
$ docker build . --tag gcr.io/$PROJECT_ID/cloudrun/$_SERVICE_ID
```

### Installation of actual application: 
Login to the Google Cloud CLI with
```
gcloud login
```
Send the container to your Google Container Registry
```
docker push gcr.io/$PROJECT_ID/cloudrun/$_SERVICE_ID
```

### Run instructions:
Then deploy the container to Google Cloud Run
```
gcloud run deploy $_SERVICE_ID --image=gcr.io/$PROJECT_ID/cloudrun/$_SERVICE_ID --platform=managed --region=us-east1
```
The CLI will then give the public URL on which the web app is running in your shell.

### Troubleshooting:
