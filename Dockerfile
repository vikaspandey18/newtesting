FROM node:20 AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Next.js static site
RUN npm run build && npm run export

# Use an Nginx base image for serving static files
FROM nginx:alpine

# Copy the generated static files to the Nginx HTML directory
COPY --from=builder /app/out /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
