FROM node:18 AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all project files
COPY . .

# Ensure Next.js builds for static export
RUN npm run build

# Use Nginx to serve static files
FROM nginx:alpine

# Copy the static output from Next.js
COPY --from=builder /app/out /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
