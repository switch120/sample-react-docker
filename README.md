# React, MySQL, Mongo, Express API Docker Shell

This project is intended to serve as a base shell for a full-stack React application with a MySQL (or Mongo) Database and an Express backend API. The local full-stack environment is defined using [Docker Compose](https://docs.docker.com/compose/), which runs three independent containers for React, Database (MySQL/Mongo), and Express simultaneously. To run Mongo instead of MySQL, you will need to modify the `db:` entry in `docker-compose.yml` and replace with the settings from `mongo.yml`.

Both the React Dev server and the Express server will detect changes and recompile automatically. Output from both can be seen while the environment is running in the foreground (i.e., without the `-d` flag)

The React source (`/src`) was built using `create-react-app@2.0.2` https://www.npmjs.com/package/create-react-app?activeTab=versions. If a more recent version is preferred, the `/src` folder can safely be over-written in its entirety as long as the start command is still `npm start`. 

> **NOTE on overwriting `/src/`** - this folder contains a `Dockerfile` for the local development environment. If you replace the contents of `/src`, just be sure to keep that file or your dev web container won't spin up.

## Requisites
* Docker (https://docs.docker.com/)
* npm >= 6
* NodeJS >= 8
* Heroku CLI (for deployment only)

## Quick Reference
* React Dev Server (frontend)
  * http://localhost:3000
* Express API (backend)
  * http://localhost:3005/api
* MySQL
  * Port: 3306
  * User: root
  * Password: root
* Mongo
  * Port: 27017
  * User: root
  * Password: root
* Docker Environment Configuration
  * Full-Stack Environment: [docker-compose.yml](docker-compose.yml)
  * React Standalone: [react.yml](react.yml)
  * Express Standalone: [express.yml](express.yml)
  * MySQL Standalone: [mysql.yml](mysql.yml)
  * Mongo Standalone: [mongo.yml](mongo.yml)

## [Notable] File Structure
This is not an exhaustive list, just some worth noting

```
+-- /api                          : Express Server
|   +-- /.env.sample              : Sample .env
|   +-- /Dockerfile               : Docker build spec for (local) Express
+-- /src                          : React App Source
|   +-- /Dockerfile               : Docker build spec for React (local) dev server
+-- /Dockerfile                   : Docker Deploy build spec for React/Express/Heroku (production build/deploy)
+-- /docker-compose.yml           : Full Stack Docker environment spec (local development)
+-- /react.yml                    : [standalone] React Docker environment spec
+-- /express.yml                  : [standalone] Express Docker environment spec
+-- /mysql.yml                    : [standalone] MySQL Docker environment spec
+-- /mongo.yml                    : [standalone] Mongo Docker environment spec
+-- /.dockerignore                : Docker copy ignore (https://docs.docker.com/engine/reference/builder/#dockerignore-file)
```

### Starting Full Stack Environment

> **First** - if you are going to need custom `environment` variables, copy `/api/.env.sample` to `/api/.env`. This file **will not be committed to source control** and is intended for local development only. These values should be matched in **Heroku Config Vars** for production apps.

To start the local development environment, run this command:

`docker-compose up`

This command will read the `docker-compose.yml` file, which specifies **build** parameters (in [Ruby syntax](https://docs.docker.com/engine/reference/commandline/build/#extended-description)) that sets up the local development environment. This is **not a production build**, this is for local only.

> **Note**: first run will build all three images (see manual rebuilding below), and will take several minutes. Subsequent restarts should be very quick.

### Terminating Environment
While `docker-compose` is running, press `CTRL+C`. Status will show Docker container instances terminating. If the environment is running in the background (`-d` command line param), you can use `docker-compose down` to terminate the environment.

### Manually rebuilding the images (not usually necessary)
`docker-compose build`
> **Note**: This runs only once automatically, on first `docker-compose up`. It should not need to be manually run again unless there is a need to delete an image from docker ([`docker rmi [imageGuid]`](https://docs.docker.com/engine/reference/commandline/image_rm/)).

> **Another Note**: It's **completely** harmless to run this at any point in time. Doing this will re-install any missing packages in your containers as long as you have not removed the `npm install` statements from each `Dockerfile`.

### Running Individual Services (instead of full-stack)
This project contains individual service configurations in addition to the default Full Stack config (`docker-compose.yml`). These individual services can be started with the following npm commands (located in `package.json`):

  * React Only - `npm run docker:react`
  * Express Only - `npm run docker:express`
  * MySQL Only - `npm run docker:mysql`
  * Mongo Only - `npm run docker:mongo`

### Connecting to Container(s) with SSH
If you run your environment in the background, you can use Docker's CLI to connect directly to a container that supports SSH. First you need to find the unique container id generated when starting the environment. To do this, use the `docker ps` command. One entry will show your react container. Second, Copy that id and then this command will connect you to SSH on that container:

`docker exec -it [copied-container-id] /bin/bash`

### Connecting to MySQL/Mongo with a client
MySQL/Mongo running as a Docker container registers itself on the local machine, so the host is `localhost` or, more reliably, `127.0.0.1` loopback address. The username and password (defined in `docker-compose.yml`) default to `root`, and the port is default `3306` for MySQL and default `27017` for Mongo.

## Deploying to Heroku
When ready, this project can be deployed to the Heroku container using the Heroku CLI. Before doing anything, log in to Heroku **and** the Heroku Container Registry.

`heroku login`

`heroku container:login`

> **Important**: For first deployment be sure to run `heroku create` to initialize the app, or use the CLI to connect to an existing project

Now you're ready to buid and deploy. An **npm** script is provided in `package.json`:

`npm run deploy`

**tl;dr;** this does the following:
* Builds the React App - outputs to `/build` folder
* Docker image built from `./Dockerfile`, which copies React build artifacts and the Express app to the deployment image
* Sets Heroku Config Var NODE_END to "production" (so Express serves static content)
* Heroku build & release

### Docker Cleanup
There is an npm script in `package.json` that will clean up "dangling" images from Docker. Every so often it's recommended you run this command:

`npm run docker:clean`
