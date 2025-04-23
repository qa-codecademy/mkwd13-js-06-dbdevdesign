import { Router } from "express";
import { userController } from "../controllers/users.js";

export const userRouter = Router();

userRouter.post("/", (req, res) => userController.createUser(req, res));
userRouter.get("/:id", (req, res) => userController.getUserById(req, res));
userRouter.get("/user-posts/:id", (req, res) =>
  userController.getUserPosts(req, res)
);
