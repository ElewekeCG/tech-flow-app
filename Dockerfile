# Use official Node.js LTS image
FROM node:18-alpine

# Set working directory
WORKDIR /tech-flow

# Copy package files first (better caching)
COPY package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# Copy the rest of the app
COPY . .

# Expose app port
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]