import User from '../entities/user.entity.js';
import { AppDataSource } from '../index.js';

class UserService {
	constructor() {
		this._userRepository = null;
	}

	get userRepository() {
		if (!this._userRepository) {
			this._userRepository = AppDataSource.getRepository(User);
		}
		return this._userRepository;
	}

	async createUser(body) {
		const createdUser = await this.userRepository.save(body);

		return createdUser;
	}

	async getAll() {
		const users = await this.userRepository.find();

		return users;
	}

	async getUserById(id) {
		const user = await this.userRepository.find({
			where: { id },
		});

		if (!user || !user.length) {
			throw new Error(`User with id: ${id} not found.`);
		}

		return user;
	}
}

export const userService = new UserService();
