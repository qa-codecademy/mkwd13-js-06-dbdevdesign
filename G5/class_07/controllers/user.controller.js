import { userService } from '../services/user.service.js';

const UserController = {
	async createUser(req, res, next) {
		try {
			const user = await userService.createUser(req.body);

			res.status(201).send(user);
		} catch (error) {
			next(error);
		}
	},

	async getAll(req, res, next) {
		try {
			const users = await userService.getAll();

			res.send(users);
		} catch (error) {
			next(error);
		}
	},

	async getUserById(req, res, next) {
		try {
			const user = await userService.getUserById(parseInt(req.params.id));

			res.send(user);
		} catch (error) {
			next(error);
		}
	},
};

export default UserController;
