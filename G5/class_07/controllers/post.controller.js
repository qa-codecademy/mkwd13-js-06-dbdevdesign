import { postService } from '../services/post.service.js';

const PostController = {
	async createPost(req, res, next) {
		try {
			const createdPost = await postService.createPost(req.body);

			res.status(201).send(createdPost);
		} catch (error) {
			next(error);
		}
	},

	async getAll(req, res, next) {
		try {
			const posts = await postService.getAll();

			res.send(posts);
		} catch (error) {
			next(error);
		}
	},
};

export default PostController;
