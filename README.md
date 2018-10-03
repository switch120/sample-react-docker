# React, MySQL, Express API Docker Shell

This project is intended to serve as a base shell for a full-stack React application with a MySQL Database and an Express backend API. The environment is defined using *docker-compose* (link), which runs three independent containers for React, MySQL, and Express simultaneously.

Both the React Dev server and the Express server will automatically detect changes and recompile automatically. Output from both can be seen while the environment is running in the foreground (i.e., without the `-d` flag (link))

The React source (`/src`) was built using `create-react-app@2.0.2` (link). If a more recent version is preferred, the `/src` folder can safely be replaced in its entirety as long as the start command is still `npm start`.

> **Important Note** - if you use this repository more than once, be sure to update each `Dockerfile` *and* the `docker-compose.yml` file to match with new image names so as not to use existing registered containers on your system.

> **Less important note** - this repo contains some extra Docker scripts in the `package.json` file. They represent some pretty cool features of NPM, and if used correctly would allow you to run a single docker container just with `npm run` commands. This was abandoned in favor if the **much easier** `docker-compose` for a true full-stack environment, but it seemed worthwhile to leave them in there for reference, in partcular, `npm run docker:ssh` which works after running `npm run docker` and gives you SSH terminal access to the Docker container running React.

## Requisites
* Docker (link)
* npm >= 6 
* NodeJS >= 8

## Quick Reference
* React Dev Server (frontend)
  * http://localhost:3000
* Express API (backend)
  * http://localhost:3005/api
* MySQL
  * Port: 3306
  * User: root
  * Password: root
* Docker Environment Configuration
  * [docker-compose.yml](docker-compose.yml)

## [Notable] File Structure
This is not an exhaustive list, just some worth noting

```
+-- /api                          : Express Server 
|   +-- /Dockerfile               : Docker build spec for Express
+-- /src                          : React App
+-- /Dockerfile                   : Docker build spec for React
+-- /docker-compose.yml           : Docker environment spec
+-- /.dockerignore                : Docker copy ignore (link)
```

### Getting started (first run)
Build the Images first: `docker-compose build`
> **Note**: This is done only once, unless there is a need to delete the image from docker (`docker images rm [imageGuid]`(link)).
This command will read the `docker-compose.yml` file, which specifies **build** parameters (in Ruby syntax (link)) as directories that contain a `Dockerfile` (link) spec.

> **Another Note**: while you only **need** to run `docker-compose build` *once*, it's **completely** harmless to run it at any point in time. Doing this will re-install any missing packages in your containers (as long as you have not removed the `npm install` statements from each `Dockerfile`)

### Starting the Environment
`docker-compose up`

### Terminating Environment
While `docker-compose` is running, press `CTRL+C`. Status will show Docker container instances terminating. If the environment is running in the background (`-d` command line param), you can use `docker-compose down` to terminate the environment.

### Connecting to MySQL with a client
MySQL running as a Docker container registers itself on the local machine, so the host is `localhost`, or more reliably `127.0.0.1` loopback address. The username and password (defined in `docker-compose.yml`) default to `root`, and the port is default `3306`.