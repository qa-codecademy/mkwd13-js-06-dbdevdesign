import { Router } from "express";
import { postController } from "../controllers/posts.js";

export const postRouter = Router();

postRouter.post("/", (req, res) => postController.createPost(req, res));
postRouter.get("/", (req, res) => postController.getAllPosts(req, res));
postRouter.get("/:id", (req, res) => postController.getPostById(req, res));
postRouter.put("/:id", (req, res) => postController.updatePost(req, res));
postRouter.delete("/:id", (req, res) => postController.deletePost(req, res));
