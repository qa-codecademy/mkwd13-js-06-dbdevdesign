import UserService from '../services/user.service.js';

const UserController = {
	async createUser(req, res) {
		try {
			const user = await UserService.createUser(req.body);

			res.status(201).send(user);
		} catch (error) {
			console.log(error);
		}
	},
};

export default UserController;
