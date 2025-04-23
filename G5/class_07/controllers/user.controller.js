import { userService } from '../services/user.service.js';

const UserController = {
	async createUser(req, res) {
		try {
			const user = await userService.createUser(req.body);

			res.status(201).send(user);
		} catch (error) {
			res.status(400).send(error);
			console.log(error);
		}
	},

	async getAll(req, res) {
		try {
			const users = await userService.getAll();

			res.send(users);
		} catch (error) {
			console.log(error);
		}
	},
};

export default UserController;
