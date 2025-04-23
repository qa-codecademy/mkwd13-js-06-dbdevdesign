# Express.js with PostgreSQL and TypeORM

This example demonstrates how to create a basic Express.js application with PostgreSQL database integration using TypeORM, following ES Modules syntax.

## Project Setup

1. Initialize a new Node.js project:

```bash
npm init -y
```

2. Install required dependencies:

```bash
npm install express pg typeorm reflect-metadata dotenv
npm install --save-dev nodemon
```

## Project Structure

```text
project-root/
├── src/
│   ├── config/
│   │   └── database.js     # TypeORM configuration
│   ├── entities/
│   │   └── User.js         # User entity
│   ├── routes/
│   │   └── users.js        # User routes
│   ├── controllers/
│   │   └── users.js        # User controllers
│   └── app.js              # Express application setup
├── .env                    # Environment variables
├── .gitignore             # Git ignore file
├── package.json           # Project dependencies
└── README.md             # Project documentation
```

## Configuration

1. Create `.env` file:

```env
DB_USERNAME=your_username
DB_PASSWORD=your_password
DB_NAME=your_database_name
DB_HOST=localhost
DB_PORT=5432
NODE_ENV=development
PORT=3000
```

2. Database configuration (`src/config/database.js`):

```javascript
import 'dotenv/config';

export const dbConfig = {
	type: 'postgres',
	host: process.env.DB_HOST || 'localhost',
	port: parseInt(process.env.DB_PORT || '5432'),
	username: process.env.DB_USERNAME,
	password: process.env.DB_PASSWORD,
	database: process.env.DB_NAME,
	synchronize: process.env.NODE_ENV === 'development',
	logging: process.env.NODE_ENV === 'development',
	entities: ['src/entities/*.js'],
	migrations: ['src/migrations/*.js'],
	subscribers: ['src/subscribers/*.js'],
};
```

## Running the Application

1. Start the development server:

```bash
npm run dev
```

## Best Practices

1. Use environment variables for configuration
2. Implement proper error handling
3. Use async/await for database operations
4. Implement input validation
5. Use proper HTTP status codes
6. Implement logging
7. Use middleware for common functionality
8. Keep controllers thin, move business logic to services

## TypeORM Specific Features

1. Entity Relationships
2. Custom Repositories
3. Query Builder
4. Migrations
5. Subscribers
6. Transactions
7. Caching

## Additional Resources

- [Express.js Documentation](https://expressjs.com/)
- [TypeORM Documentation](https://typeorm.io/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
