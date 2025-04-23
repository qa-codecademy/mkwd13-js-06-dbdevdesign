import { AppDataSource } from '../index.js';
import { Post } from '../entities/post.entity.js';

class PostService {
	constructor() {
		this._postRepository = null;
	}

	get postRepository() {
		if (!this._postRepository) {
			this._postRepository = AppDataSource.getRepository(Post);
		}

		return this._postRepository;
	}

	async createPost(body) {
		const createdPost = await this.postRepository.save(body);

		return createdPost;
	}

	async getAll() {
		const posts = await this.postRepository.find({
			relations: ['author'],
			select: {
				id: true,
				title: true,
				content: true,
				author: {
					id: true,
					email: true,
					name: true,
				},
				createdAt: true,
			},
		});

		return posts;
	}
}

export const postService = new PostService();
