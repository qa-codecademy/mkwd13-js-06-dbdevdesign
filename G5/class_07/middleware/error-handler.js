export default function errorHandler(err, req, res, next) {
	console.log('IN THE MIDDLEWARE', err);

	res.status(err.statusCode || 500).json({
		status: err.status,
		message: err.message,
		error: err,
		stack: err.stack,
	});
}
