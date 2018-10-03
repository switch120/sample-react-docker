# React, MySQL, Express API Docker Shell

This project is intended to serve as a base shell for a full-stack React application with a MySQL Database and an Express backend API. The environment is defined using *docker-compose* (link), which runs three independent containers for React, MySQL, and Express.

Both the React Dev server and the Express server will automatically detect changes and recompile automatically. Output from both can be seen while the environment is running in the foreground (i.e., without the `-d` flag (link))

## Requisites
* Docker
* npm
* nodeJS

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
|   +-- /Dockerfile               : Docker build config for Express
+-- /src                          : React App
+-- /Dockerfile                   : Docker build config for React
+-- /docker-compose.yml           : Docker environment config
+-- /.dockerignore                : Docker copy ignore (link)
```

### Getting started (first run)
Build the Images first: `docker-compose build`
> Note: This is done only once, unless there is a need to delete the image from docker (`docker images rm [imageGuid]`(link))
This command will read the `docker-compose.yml` file, which specifies *build* parameters (in Ruby syntax (link)) as directories that contain a `Dockerfile` (link) spec.

### Starting the Environment
`docker-compose up`

### Terminating Environment
While `docker-compose` is running, press `CTRL+C`. Status will show Docker container instances terminating.