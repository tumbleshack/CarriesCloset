# Technical Overview

This webapp for Carrie's Closet of Georgia runs using [Ruby on Rails](https://rubyonrails.org/), a full-stack framework for [CRUD web apps](https://www.codecademy.com/articles/what-is-crud). The best resource for learning about and debugging common Rails problems is the [official Rails guide](https://guides.rubyonrails.org/), which were used extensively during development. Rails beleives in "convention over configuration," so many features needed came out of the box. Many also come from packages, which Rails calls Gems. Notable Gems used by this webapp include: `devise`, `devise-invitable`, `webpakcer`, and `puma`. Gems can suffer from the [bloated dependency problem](https://res.cloudinary.com/practicaldev/image/fetch/s--hHU5ov3u--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://preview.redd.it/eu7hrdzzy3x11.jpg%3Fwidth%3D640%26crop%3Dsmart%26auto%3Dwebp%26s%3D18ed21e9420e1b0fb327c3d356f0c47eb28f9aa2), so tread carefully when adding new ones.

The app is deployed on Google Cloud using their managed [Kubernetes](https://kubernetes.io/) platform, [Google Cloud Run](https://cloud.google.com/run). The binaries are packaged into a [Docker](https://docs.docker.com/get-started/overview/) container, which Google scales automagically based on request intensity. Current configuration allows Google to shut down all container instances when not in use, which means Carrie's Closet gets around 1.2 million free monthly requests (although first requests in more than an hour can be slow). Postgres is used for the database, which is also hosted with Google Cloud, and is currently the only hosting cost. For details on how to deploy to these services, continue reading.

# Local Installation (for testing/development)

See [README.md](README.md)

# Production Instance

Production app goes on Google Cloud. The source code will be built into a Docker container locally, then pushed to a container registry, then deployed.

### Pre-requisites
1. A Google Cloud account
2. A project on Google Cloud with billing enabled, as well as the Cloud Run API, [Cloud SQL API](https://console.cloud.google.com/flows/enableapi?apiid=sqladmin&redirect=https://console.cloud.google.com&_ga=2.123185100.670298711.1619196945-1893429947.1619196945), and Google Contiainer Registry enabled

Go to the Google Cloud Console and find the SQL service. Create a PostgreSQL instance. The minium resources should be sufficient:
- Shared CPU without High Availablility
- 1/2 GB Memory
- 10 GB HDD Storage
- Keep a up to 7 backups

Create a new user for the PostgreSQL instance in the Users menu of the instance page. Select "ADD USER ACCOUNT" then select the "PostgreSQL" radio button. Make a user name and password, note these somewhere.

Now, grant your Default compute service account Cloud SQL Admin permissions to allow the webapp access to the databse. Go to Google Cloud's IAM service.

Locate the service account `{somenumber}-compute@developer.gserviceaccount.com`. If this account does not exist, proceede to the next step, and return here after completing the "Run Instructions" section.

Click on the edit member icon for `{somenumber}-compute@developer.gserviceaccount.com`. Select "ADD ANOTHER ROLE". Locate Cloud SQL Admin (make sure the Cloud SQL Admin API is enabled). Save.

### Seed the Database

If the deployment is fresh (ie. database has never been setup before), the database will need to be seeded. The seeds are set in the file [db/seeds.rb](db/seeds.rb). **Make sure to change the administrator seed** before proceeding.

To seed the database, run the docker container on your local machine, connect it to the Google Cloud PostgreSQL instance, then execute the seed command inside the container. 

First, authorize your local network to connect with Cloud SQL. Go to the Google Cloud Console page for the PostgreSQL instance, and view the "Connections" tab. Add your public IP address to the list of "Authorized networks."

Next, copy the IP address of your PostgreSQL instance, found on the "Overview" tab. Make sure it's a public IP address. Open the file [config/database.yml](config/database.yml) and temporarily change the `host` field under `production` to the PostgreSQL IP address just copied. 

Now, set all the environment variables specified in the _**Run Instructions:**_ section of this document by temporarily adding them to the Dockerfile. Build the container as specified in _Build Instructions_ and run it with:
```
docker run --name cc_server_seed -d gcr.io/$PROJECT_ID/cloudrun/$_SERVICE_ID
```
Once running, execute the seed command inside the container with:
```
docker exec cc_server_seed bin/rails db:create db:migrate db:seed
```
Once the seed finishes, it's safe to stop the container with:
```
docker stop cc_server_seed
```
Restore the Dockerfile and [config/database.yml](config/database.yml) file back to their original states, and proceed with installation.

### Dependent Libraries that must be Installed on your Machine:
1. [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. [Git](https://git-scm.com/downloads)
3. [Google Cloud CLI](https://cloud.google.com/sdk) (Command Line Interface)

### Download Instructions: 
Clone the repository (it's open source) by runing in your shell: 

```$ git clone https://github.com/tumbleshack/CarriesCloset.git```

### Build Instructions
Prepare your environment by setting your Google Cloud project id:
```
$ export PROJECT_ID=your-project-id
```
Create a name for your cloud run service, we suggest:
```
$ export _SERVICE_ID=carries-closet-webapp
```
Generate the file `config/master.key` by running in your shell:
```
$ EDITOR=vim rails credentials:edit
```
Exit vim by typing `:wq`.

Next, build the container by running:
```
$ docker build f Dockerfile.prod . --tag gcr.io/$PROJECT_ID/cloudrun/$_SERVICE_ID
```

### Installation of Application: 
Login to the Google Cloud CLI with:
```
gcloud auth login
```
Send the container to your Google Container Registry:
```
docker push gcr.io/$PROJECT_ID/cloudrun/$_SERVICE_ID
```

### Run Instructions:
Now deploy the container to Google Cloud Run.
```
gcloud run deploy $_SERVICE_ID --image=gcr.io/$PROJECT_ID/cloudrun/$_SERVICE_ID --platform=managed --region=us-east1 --allow-unauthenticated
```
The CLI will then give the public URL on which the web app is running in your shell. Go to the Google Cloud Console, locate the Cloud Run service, and select "EDIT & DEPLOY NEW REVISION." Go the "VARIABLES" tab. Add the following environment variables:
- `RAILS_ENV`: `production`
- `RAILS_MASTER_KEY`: the key found in `config/master.key`
- `DATABASE_USERNAME`: username you set for the PostgreSQL instance
- `DATABASE_PASSWORD`: password you set for the PostgreSQL username
- `RAILS_LOG_TO_STDOUT`: `true`
- `INSTANCE_CONNECTION_NAME`: {project-id}:{postgres-region}:{postgres-instance-id}, for example `carries-closet:us-central1:closet-db-1`

Go to the CONTAINER tab, and set Port to `3000`

Go to the CONNECTIONS tab. Under the "Cloud SQL connections" heading, select your PostgreSQL instance in the dropdown.

Then click the "DEPLOY" button.

### Troubleshooting:

The Cloud Run logs are the most helpful resource for debugging problems. You can locate them in the "LOGS" tab of the Cloud Run service's page. If the service fails to deploy, Cloud Run will present a link to the relevent logs in the Google Cloud Console. Tips for some common problems:

**Cloud Run fails to connect to the Database**

Ensure the environment variables `DATABASE_USERNAME`, `DATABASE_PASSWORD`, `INSTANCE_CONNECTION_NAME` are set correctly. Read about the instance connection name and general database connection [here](https://cloud.google.com/sql/docs/mysql/connect-run)

**A `gcloud` command fails**

Read about gcloud authorization [here](https://cloud.google.com/sdk/gcloud/reference/auth/login).

**Rails encounters a secret key error**

Ensure the environment variable `RAILS_MASTER_KEY` matches the master key in the file. Every time a new master key is generated, this variable must be updated.
