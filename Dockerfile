# Stage 1: Build static site (optional)
FROM node:18-alpine AS builder
WORKDIR /app

# Copy your static site files (HTML, CSS, JS)
COPY . .

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=builder /app /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

