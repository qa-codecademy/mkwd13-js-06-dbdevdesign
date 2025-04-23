import "dotenv/config";

// This single object exports all the settings our ORM needs to connect, authenticate, and manage the Postgres database, while keeping secrets out of the code and enabling helpful “dev-only” features like automatic schema sync and SQL logging
export const dbConfig = {
  // Tells the ORM (in our case TypeORM) which database driver to load. Here it’s set to PostgreSQL
  type: "postgres",
  // The database server’s address. It first looks at the environment variable DB_HOST; if that isn’t defined, it falls back to 'localhost'
  host: process.env.DB_HOST || "localhost",
  // // Which TCP port to connect on. It reads DB_PORT from the environment (e.g. "5433"), or defaults to "5433" if not set, and then uses parseInt(...) to convert that string into a number
  port: parseInt(process.env.DB_PORT || "5433"),
  // Credentials
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  // When true, the ORM will automatically create or update your tables to match the entity definitions
  // We almost always only want this in development—hence the check against NODE_ENV
  synchronize: process.env.NODE_ENV === "development", // Auto-create tables in development
  // Enables SQL-query logging to the console, also gated to development so we don’t flood the production logs
  logging: process.env.NODE_ENV === "development",
  // Tells the ORM where to find your entity (model) classes. Here it will load every .js file in
  entities: ["src/entities/*.js"],
  // Points to the migration scripts. These are files that describe step-by-step schema changes we can run to update the DB
  migrations: ["src/migrations/*.js"],
  // Lists any event listeners you’ve written (e.g. hooks that fire before or after insert/update).
  subscribers: ["src/subscribers/*.js"],
};
