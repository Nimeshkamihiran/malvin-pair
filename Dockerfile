# Use a newer Node.js base image (Debian 11 bullseye)
FROM node:lts-bullseye

# Install required packages
RUN apt-get update && \
    apt-get install -y \
      ffmpeg \
      imagemagick \
      webp && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package.json first (for caching npm install layers)
COPY package.json .

# Install dependencies
RUN npm install && npm install -g qrcode-terminal pm2

# Copy all source files
COPY . .

# Expose app port
EXPOSE 5000

# Start app
CMD ["npm", "start"]
