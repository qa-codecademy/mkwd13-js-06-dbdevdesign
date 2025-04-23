import { userService } from "../services/userService.js";
import { handleError } from "../util/util.js";

class UserController {
  async createUser(req, res) {
    try {
      const user = await userService.createUser(req.body);
      res.status(201).json(user);
    } catch (error) {
      handleError(res, error);
    }
  }

  async getUserById(req, res) {
    try {
      const id = parseInt(req.params.id);
      const user = await userService.getUserById(id);
      res.json(user);
    } catch (error) {
      handleError(res, error);
    }
  }

  async getUserPosts(req, res) {
    try {
      const id = parseInt(req.params.id);
      const posts = await userService.getUserPosts(id);
      res.json(posts);
    } catch (error) {
      handleError(res, error);
    }
  }
}

export const userController = new UserController();
