# Carrie's Closet
*Note*: This branch changes the version of Ruby for the project. Check 
`ruby -v`. If it is `ruby 2.7.2p...`, you're good to go.

You'll need to install `rvm` if you don't have it (`rvm -v` gives an error). To 
set the proper version for this branch, run `rvm install 2.7.2`. Once Ruby 
2.7.2 is installed, switch to it with `rvm use 2.7.2`.

## Getting Started
On windows, make sure you set git [to use unix line endings](https://docs.github.com/en/github/using-git/configuring-git-to-handle-line-endings) 
when checking out and committing. 

If you've already checked out and have windows line endings, you may encounter
an error stating: `env: ruby\r: No such file or directory`. To resolve, run
`find ./ -type f -exec dos2unix {} \;`.

After a clean install of this repo, you'll need to run `bundle install` inside 
the `CarriesCloset` root folder. This will install all needed requirements.
  
Additionally, **duplicate** the file `example.env` in the root level directory. 
Once duplicated, rename the duplicate, e.g. `example.env (1)`, to just `.env`. 
This may cause the `.env` to disapear from your file brower, but don't worry 
if you've named the file correctly.

Try running `bin/rails server`. Try the "Running with Docker" section if this 
fails.

## Database Creation
You'll need to have MySQL installed and running locally.

## Database Initialization
Depending on whether or not you've run the Rails server recently, or if you're 
  having troubles with your database/server, you'll want to run the following:
```shell
bin/rails db:drop
bin/rails db:create db:migrate db:seed
```

## Asset Installation
To install all the packaged Javascript libraries locally (suggested for 
performance improvements), run:
```shell
bin/rails webpacker:install
```

## Running with Docker
### Initial Set Up
To start the full app stack for the first time, run the following commands:
```shell
docker-compose build --parallel
docker-compose up -d
docker exec cc_server bin/rails db:create
docker exec cc_server bin/rails db:environment:set RAILS_ENV=development
docker exec cc_server bin/rails db:migrate db:seed
docker exec cc_server bin/rails webpacker:install
```

This will create the `cc_mysql` MySQL Docker container, the `cc_redis` Redis
caching store, and the `cc_server` Rails server. Both commands should complete
without error to let you know everything is running properly. The Rails server
will run on http://127.0.0.1:3000 in most environments.

### Regular Usage
To check whether all the containers are running, run `docker-compose ps` inside 
the project folder. You should see all 3 containers (`cc_mysql`, `cc_redis`, 
and `cc_server`) in the `Up` state.

To start all containers, run `docker-compose up -d`. To stop all containers, 
run `docker-compose stop`.

To "drop in" to the server (to access Rails commands directly), run `docker 
exec -it cc_server sh`. This will allow you direct access to the running 
server, so Rails commands like `bin/rails console` will work as expected. 
You'll want to stay in here for the majority of your work. Run `exit` to leave 
the container.

## General Rails Tips
- Always use `bin/rails` when running commands from the terminal (this will 
  point to the proper Carrie's Closet project)
- `bin/rails console --sandbox` will create a sandboxed version of a REPL-style 
  console, loaded with all the classes and data from your running app. Any 
  changes made in the sandbox will be reverted when you `exit`.
- `bin/rails generate Tweet user:references body:text likes:integer` will 
  create a `Tweet` model that belongs to a `User` model. Each `Tweet` will be 
  stored in the database with a `body` text field and a `likes` counter.
- `bin/rails destroy Tweet` will revert all generated files for the previous
  `Tweet` model.
