# This Dockerfile is for Heroku deployments only!

# A node.js v8 box
FROM node:8

# Who(m) to blame if nothing works
#MAINTAINER nobody@nowhere.com

# Create a working directory 
RUN mkdir -p /var/www

# Switch to working directory
WORKDIR /var/www

# Copy contents of api folder to `WORKDIR` (root of build is now Express App)
COPY ./api .
# Copy the React build artifacts to a separate folder for static middleware
COPY ./build ./build

# Install dependencies ... package.json from ./api is now in the root of container (so it's referenced here!)
RUN npm install

# NOTE: Heroku does not support specifying ports

# Start the Node.js app on load
CMD [ "npm", "start" ]
