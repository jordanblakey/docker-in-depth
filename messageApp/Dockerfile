FROM node:4.4.5
ENV LAST_UPDATED 20201206T205900

# Copy source code
COPY . /app

# Change working directory
WORKDIR /app

# Install dependencies
RUN npm install

# Expose API port to the outside
EXPOSE 80

# Launch application
CMD ["npm", "start"]
