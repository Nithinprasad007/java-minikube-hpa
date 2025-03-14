# Use an official OpenJDK base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the compiled Java class
COPY HelloWorld.class /app/

# Expose port 8080
EXPOSE 8080

# Run the app
CMD ["java", "HelloWorld"]
