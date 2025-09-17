# Stage 1: Build React app
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (only production deps if needed)
RUN npm install --legacy-peer-deps

# Copy source files
COPY . .

# Build the app
RUN npm run build


# Stage 2: Serve with Nginx (small final image)
FROM nginx:alpine

# Copy build output from builder
COPY --from=builder /app/build /usr/share/nginx/html

# Copy custom Nginx config if you have one (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

