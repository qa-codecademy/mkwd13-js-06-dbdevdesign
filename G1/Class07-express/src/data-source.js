// TypeORM (and many other decorator-based libraries) relies on the Metadata Reflection API to inspect the entity classes at runtime.
// Simply importing this module once at startup patches in the Reflect API so decorators like @Entity(), @Column(), etc., can store and read metadata about the classes.
import "reflect-metadata";
// DataSource is TypeORM’s core class for managing one database connection (or “data source”).
// It knows about the entities, migrations, subscribers, and connection settings.
import { DataSource } from "typeorm";
// Here ew’re pulling in the configuration object we defined earlier—host, port, credentials, entities paths, synchronize flag, etc
import { dbConfig } from "./config/database.js";
// Create a singleton AppDataSource by passing the dbConfig into the DataSource constructor
// Ties the config into a reusable object we can initialize and then use everywhere to talk to the database
export const AppDataSource = new DataSource(dbConfig);
