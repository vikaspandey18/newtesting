Step-by-Step Instructions

1. Create Your Next.js Project: If you haven't already, create your Next.js project and navigate to its directory.

2. Create the Dockerfile: In the root of your Next.js project, create a file named Dockerfile and add the following content:
```
# Step 1: Build the Next.js application

FROM node:16 AS builder

# Set the working directory

WORKDIR /app

# Copy package.json and package-lock.json

COPY package\*.json ./

# Install dependencies

RUN npm install

# Copy the rest of the application code

COPY . .

# Build the Next.js application

RUN npm run build

# Step 2: Serve the application using Nginx

FROM nginx:alpine

# Copy the built application from the builder stage

COPY --from=builder /app/out /usr/share/nginx/html

# Copy the Nginx configuration file

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port that Nginx will run on

EXPOSE 80

# Start Nginx

CMD ["nginx", "-g", "daemon off;"]
```

3. Create the Nginx Configuration File: In the same directory, create a file named nginx.conf and add the following content:
```
server {
listen 80;

    location / {
        root /usr/share/nginx/html;
        try_files $uri $uri/ /index.html;
    }

}
```

4. Build the Docker Image: Open your terminal, navigate to your project directory, and run the following command to build the Docker image:
```
docker build -t my-nextjs-app .
```
5. Run the Docker Container: After the image is built, you can run the container with:
```
docker run -p 80:80 my-nextjs-app
```
Deploying to AWS EC2
Launch an EC2 Instance: Use an Amazon Machine Image (AMI) that supports Docker (e.g., Amazon Linux 2).
SSH into Your EC2 Instance: Use your terminal to connect to your EC2 instance.
Install Docker: If Docker is not already installed, you can install it with the following commands

Build and Run Your Docker Container on EC2: SSH into your EC2 instance and navigate to your project directory. Then run the following commands:
```
cd nextjs-project
docker build -t my-nextjs-app .
docker run -p 80:80 my-nextjs-app
```
