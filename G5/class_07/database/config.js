import 'dotenv/config';

const dbConfig = {
	type: 'postgres',
	host: process.env.DB_HOST || 'localhost',
	port: parseInt(process.env.DB_PORT || '5433'),
	username: process.env.DB_USERNAME,
	password: process.env.DB_PASSWORD,
	database: process.env.DB_NAME,
	synchronize: true,
	logging: true,
	entities: ['entities/*.js'],
};

export default dbConfig;
