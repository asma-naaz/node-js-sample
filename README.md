Automate Code Deployment Using CI/CD Pipeline (GitHub Actions)
TOOLS : github & github action and Docker

step:1
git clone https://github.com/heroku/node-js-sample
cd node-js-sample

step:2 
create a docker file 
nano dockerfile
# Use official Node.js image
FROM node:16

# Set working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# App runs on port 5000
EXPOSE 5000

# Command to run the app    #index.js is the main file in this repo  #5000 is the port this app uses
CMD ["node", "index.js"]

step:3 
Build and Run Docker Container 
docker build -t my-node-app .
docker run -p 5000:5000 my-node-app

test : http://localhost:5000

step:4 
GitHub Actions for CI/CD 
✅ 1. Create this folder in your repo:
mkdir -p .github/workflows/
touch .github/workflows/main.yml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Code
      uses: actions/checkout@v2

    - name: Set up Docker
      uses: docker/setup-buildx-action@v2

    - name: Log in to DockerHub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build and Push Docker image
      uses: docker/build-push-action@v4
      with:
        context: .
        push: true
        tags: <your-dockerhub-username>/nodejs-demo-app:latest

step:5 
Add DockerHub Credentials to GitHub Secrets
Go to your repo on GitHub:

Click Settings > Secrets and variables > Actions
Click "New repository secret"

Add two secrets:
Name	Value
DOCKER_USERNAME	your DockerHub username
DOCKER_PASSWORD	your DockerHub password

✅ Once you push this to GitHub, GitHub Actions will automatically:

Build the Docker image

Push it to DockerHub




