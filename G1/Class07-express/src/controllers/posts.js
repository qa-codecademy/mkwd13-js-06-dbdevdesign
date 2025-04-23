import { postService } from "../services/postService.js";
import { handleError } from "../util/util.js";

export class PostController {
  async createPost(req, res) {
    try {
      // In a real app, authorId would come from authenticated session
      const post = await postService.createPost(req.body, req.body.authorId);
      res.status(201).json(post);
    } catch (err) {
      handleError(res, err);
    }
  }

  async getAllPosts(req, res) {
    try {
      const posts = await postService.getAllPosts();
      res.json(posts);
    } catch (err) {
      handleError(res, err);
    }
  }

  async getPostById(req, res) {
    try {
      const id = parseInt(req.params.id, 10);
      const post = await postService.getPostById(id);
      res.json(post);
    } catch (err) {
      handleError(res, err);
    }
  }

  async updatePost(req, res) {
    try {
      const id = parseInt(req.params.id, 10);
      // In a real app, authorId would come from authenticated session
      const updated = await postService.updatePost(
        id,
        req.body,
        req.body.authorId
      );
      res.json(updated);
    } catch (err) {
      handleError(res, err);
    }
  }

  async deletePost(req, res) {
    try {
      const id = parseInt(req.params.id, 10);
      // In a real app, authorId would come from authenticated session
      await postService.deletePost(id, req.body.authorId);
      res.status(204).send();
    } catch (err) {
      handleError(res, err);
    }
  }
}

export const postController = new PostController();
