import { Router } from 'express';
import UserController from '../controllers/user.controller.js';

const router = new Router();

router.post('/', UserController.createUser);
router.get('/', UserController.getAll);
router.get('/:id', UserController.getUserById);

export default router;
