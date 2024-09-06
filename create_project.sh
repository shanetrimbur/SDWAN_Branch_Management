#!/bin/bash

# Project root directory
PROJECT_NAME="SDWAN_Branch_Management"
echo "Creating project directory: $PROJECT_NAME"
mkdir -p $PROJECT_NAME

# Backend (Node.js)
echo "Creating backend folder structure..."
mkdir -p $PROJECT_NAME/backend
cd $PROJECT_NAME/backend
mkdir -p routes controllers models config

# Create basic backend files
cat > package.json <<EOL
{
  "name": "sdwan-backend",
  "version": "1.0.0",
  "description": "Backend for SD-WAN Branch Management Tool",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.17.1",
    "pg": "^8.6.0",
    "body-parser": "^1.19.0"
  }
}
EOL

touch index.js  # Main entry point for the backend

# Create sample files for routes, controllers, and models
touch routes/branchRoutes.js
touch controllers/branchController.js
touch models/branchModel.js
touch config/db.js

# Go back to the root folder
cd ../

# Frontend (React.js)
echo "Creating frontend folder structure..."
npx create-react-app frontend

# Database setup
echo "Creating database folder for SQL scripts..."
mkdir -p database
cd database

# Sample SQL file for PostgreSQL schema
cat > create_tables.sql <<EOL
CREATE TABLE branches (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    ip VARCHAR(50),
    primary_link VARCHAR(50),
    backup_link VARCHAR(50)
);

CREATE TABLE policies (
    id SERIAL PRIMARY KEY,
    branch_id INT REFERENCES branches(id),
    latency_threshold INT,
    app_priority VARCHAR(100)
);

CREATE TABLE performance (
    id SERIAL PRIMARY KEY,
    branch_id INT REFERENCES branches(id),
    latency INT,
    jitter INT,
    packet_loss FLOAT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOL

cd ../

# Documentation & README
echo "Creating documentation folder..."
mkdir -p docs

# Create README file
cat > README.md <<EOL
# SD-WAN Branch Office Connectivity Management Tool

## Project Structure

- **backend**: Node.js API to manage branch policies, performance, and connectivity.
- **frontend**: React.js front-end for the admin dashboard.
- **database**: SQL scripts for PostgreSQL to set up the schema for branches, policies, and performance.
- **docs**: Documentation and API specs.

## How to Run

### Backend
1. Install dependencies:
   \`\`\`
   cd backend
   npm install
   \`\`\`
2. Start the backend server:
   \`\`\`
   npm start
   \`\`\`

### Frontend
1. Install dependencies:
   \`\`\`
   cd frontend
   npm install
   \`\`\`
2. Start the frontend development server:
   \`\`\`
   npm start
   \`\`\`

### Database
1. Set up PostgreSQL and run the \`create_tables.sql\` script:
   \`\`\`
   psql -U <your-user> -d <your-database> -f database/create_tables.sql
   \`\`\`

EOL

echo "Project structure created successfully."

