# ----------------------
# STAGE 1: Build React
# ----------------------
    FROM node:18 AS builder
    WORKDIR /app
    
    # Copy React package files
    COPY ../frontend/package*.json ./
    RUN npm install
    
    # Copy the rest of your React source
    COPY ../frontend/ . 
    
    # Produce a production build (ends up in /app/build or /app/dist, depending on your config)
    RUN npm run build
    # If create-react-app, this typically produces /app/build
    
    # ----------------------
    # STAGE 2: Nginx
    # ----------------------
    FROM nginx:stable
    
    # Remove default nginx config if it exists
    RUN rm /etc/nginx/conf.d/default.conf
    
    # Copy our custom config (see next file) into Nginx
    COPY default.conf /etc/nginx/conf.d/
    
    # Copy the React build output from the builder stage
    # If your build folder is /app/build, adjust accordingly:
    COPY --from=builder /app/build /usr/share/nginx/html
    
    # Expose port 80 inside the container
    EXPOSE 80
    
    # Start Nginx in the foreground
    CMD ["nginx", "-g", "daemon off;"]