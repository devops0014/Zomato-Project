# Stage 1: Build
FROM node:16-slim AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Production
FROM node:16-slim

# Set the working directory
WORKDIR /app

# Copy only the build output from the builder stage
COPY --from=builder /app/build ./build

# Install only production dependencies
COPY package*.json ./
RUN npm install --production

# Expose the application's port
EXPOSE 3000

# Start your Node.js server
CMD ["npm", "start"]
