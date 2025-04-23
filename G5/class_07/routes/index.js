import { Router } from 'express';
import userRouter from './user.routes.js';
import postRouter from './post.routes.js';

const router = new Router();

router.use('/users', userRouter);
router.use('/posts', postRouter);

export default router;
