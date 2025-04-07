🚀 Automate Code Deployment Using CI/CD Pipeline (GitHub Actions)
Tools Used: GitHub, GitHub Actions, Docker

✅ Step 1: Clone the Sample Node.js App
bash
Copy
Edit
git clone https://github.com/heroku/node-js-sample
cd node-js-sample

✅ Step 2: Create a Dockerfile
Create a file named Dockerfile:
Dockerfile
Copy
Edit
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
# Command to run the app
CMD ["node", "index.js"]


✅ Step 3: Build and Run Docker Container
bash
Copy
Edit
docker build -t my-node-app .
docker run -p 5000:5000 my-node-app
Test in browser: http://localhost:5000


✅ Step 4: Set Up GitHub Actions for CI/CD
Create the folder and workflow file:

mkdir -p .github/workflows
touch .github/workflows/main.yml
Add the following to .github/workflows/main.yml:

yaml
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


✅ Step 5: Add DockerHub Credentials to GitHub Secrets
Go to your GitHub repository:

Click Settings > Secrets and variables > Actions

Click "New repository secret" and add:

Name	Value
DOCKER_USERNAME	Your DockerHub username
DOCKER_PASSWORD	Your DockerHub password
✅ Outcome
Once you push to GitHub:

The workflow will build your Docker image

Push it to DockerHub automatically 🎉

