FROM nginx:alpine

# Install hugo and git
RUN apk add --no-cache hugo git

# Create working directories
RUN mkdir -p /build /site

# Set working directory for building
WORKDIR /build

# Copy source files to build directory
COPY . /build/

# Copy example site to the site directory
RUN cp -r /build/exampleSite/* /site/

# Create themes directory and copy cstate theme
RUN mkdir -p /site/themes/cstate && \
    cp -r /build/* /site/themes/cstate/

# Change to site directory and build
WORKDIR /site

# Build the Hugo site
RUN hugo --minify

# Copy built files to nginx directory
RUN cp -r /site/public/* /usr/share/nginx/html/

# Clean up build files
RUN rm -rf /build /site

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]