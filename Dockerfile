# Use nginx to serve static files
FROM nginx:alpine

# Copy all files to nginx html directory
COPY . /usr/share/nginx/html

# Create custom nginx config for Cloud Run
RUN echo 'server { \
    listen 8080; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Expose port 8080 (required by Cloud Run)
EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]