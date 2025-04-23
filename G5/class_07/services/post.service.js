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
}

export const postService = new PostService();
