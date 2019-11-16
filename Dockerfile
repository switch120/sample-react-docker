# This Dockerfile is for Heroku deployments only!

# A node.js v10 box
FROM node:10

# Who(m) to blame if nothing works
#MAINTAINER nobody@nowhere.com

# Create a working directory 
RUN mkdir -p /var/www

# Switch to working directory
WORKDIR /var/www

# Set the environment for Heroku
ENV NODE_ENV=production

# Copy contents of api folder to `WORKDIR` (root of build is now Express App)
COPY ./api .
COPY ./src ./src
COPY ./public ./public

# Copy the React build artifacts to a separate folder for static middleware
# COPY ./build ./build

# Install dependencies ... package.json from ./api is now in the root of container (so it's referenced here!)
RUN yarn install

#RUN npm install -g react react-scripts

# Build the React App
RUN node_modules/.bin/react-scripts build

# NOTE: Heroku does not support specifying ports

# Start the Node.js app on load
CMD [ "npm", "start" ]
