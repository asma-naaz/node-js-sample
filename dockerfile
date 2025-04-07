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
