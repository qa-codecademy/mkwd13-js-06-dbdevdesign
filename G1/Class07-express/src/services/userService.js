import { AppDataSource } from "../data-source.js";
import { User } from "../entities/User.js";

class UserService {
  constructor() {
    this.userRepository = AppDataSource.getRepository(User);
  }

  async createUser(userData) {
    const user = await this.userRepository.save(userData); // save returns the newly created row
    delete user.password;
    return user;
  }

  async getUserById(id) {
    const user = await this.userRepository.findOne({
      where: { id },
      select: ["id", "username", "email", "createdAt"],
    });

    if (!user) {
      throw new Error("Not found");
    }
    return user;
  }

  async getUserPosts(id) {
    const user = await this.userRepository.findOne({
      where: { id },
      relations: ["posts"],
    });

    if (!user) {
      throw new Error("Not found");
    }
    return user.posts;
  }
}

export const userService = new UserService();
