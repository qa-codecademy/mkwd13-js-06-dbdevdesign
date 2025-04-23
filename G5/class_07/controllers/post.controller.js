import { postService } from '../services/post.service.js';

const PostController = {
	async createPost(req, res) {
		try {
			const createdPost = await postService.createPost(req.body);

			res.status(201).send(createdPost);
		} catch (error) {
			console.log(error);
		}
	},
};

export default PostController;
