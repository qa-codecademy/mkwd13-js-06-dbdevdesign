import { AppDataSource } from "../data-source.js";
import { Post } from "../entities/Post.js";

class PostService {
  constructor() {
    this.postRepository = AppDataSource.getRepository(Post);
  }

  async createPost(postData, authorId) {
    const post = await this.postRepository.save({
      ...postData,
      author: { id: authorId },
    });

    return this.getPostById(post.id);
  }

  // By default, a find() will not automatically pull in related entities.
  // Adding relations: ["author"] tells TypeORM to do a SQL JOIN on the author relation (the @ManyToOne side in the Post entity).
  // In the resulting JavaScript objects, each post will have an .author property containing the full User entity.
  async getAllPosts() {
    return this.postRepository.find({
      relations: ["author"],
      select: {
        // whitelist which columns of the user table to be returned
        author: {
          id: true,
          username: true,
          email: true,
        },
      },
    });
  }

  async getPostById(id) {
    const post = await this.postRepository.findOne({
      where: { id },
      relations: ["author"],
      select: {
        author: {
          id: true,
          username: true,
          email: true,
        },
      },
    });

    if (!post) {
      throw new Error("Not found");
    }

    return post;
  }

  async updatePost(id, postData, authorId) {
    const post = await this.getPostById(id);

    // verify post ownership
    if (post.authorId !== authorId) {
      throw new Error("Unauthorized to update");
    }

    // Prevent updating certain fields
    delete postData.id;
    delete postData.authorId;
    delete postData.createdAt;

    await this.postRepository.update(id, postData);
    return this.getPostById(id);
  }

  async deletePost(id, authorId) {
    const post = await this.getPostById(id);

    // verify post ownership
    if (post.authorId !== authorId) {
      throw new Error("Unauthorized to update");
    }

    await this.postRepository.delete(id);
    return true;
  }
}

export const postService = new PostService();
