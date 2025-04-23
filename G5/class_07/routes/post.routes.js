import { Router } from 'express';
import PostController from '../controllers/post.controller.js';

const router = new Router();

router.post('/', PostController.createPost);
router.get('/', PostController.getAll);

export default router;
