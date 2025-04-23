import 'reflect-metadata';
import 'dotenv/config';
import express from 'express';
import router from './routes/index.js';
import { DataSource } from 'typeorm';
import dbConfig from './database/config.js';
import errorHandler from './middleware/error-handler.js';

const app = express();

const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || localhost;

// Init TypeORM
export const AppDataSource = new DataSource(dbConfig);

// Middleware
app.use(express.json());

app.use('/api', router);

// Middleware part 2 :D
app.use(errorHandler);

(async () => {
	try {
		await AppDataSource.initialize();

		app.listen(PORT, HOST, () => {
			console.log(`Server started listening on http://${HOST}:${PORT}`);
		});
	} catch (error) {
		console.error('Error during database initialization', error);
		process.exit(1);
	}
})();
