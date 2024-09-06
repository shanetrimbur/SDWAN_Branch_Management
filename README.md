# SD-WAN Branch Office Connectivity Management Tool

## Project Structure

- **backend**: Node.js API to manage branch policies, performance, and connectivity.
- **frontend**: React.js front-end for the admin dashboard.
- **database**: SQL scripts for PostgreSQL to set up the schema for branches, policies, and performance.
- **docs**: Documentation and API specs.

## How to Run

### Backend
1. Install dependencies:
   ```
   cd backend
   npm install
   ```
2. Start the backend server:
   ```
   npm start
   ```

### Frontend
1. Install dependencies:
   ```
   cd frontend
   npm install
   ```
2. Start the frontend development server:
   ```
   npm start
   ```

### Database
1. Set up PostgreSQL and run the `create_tables.sql` script:
   ```
   psql -U <your-user> -d <your-database> -f database/create_tables.sql
   ```

