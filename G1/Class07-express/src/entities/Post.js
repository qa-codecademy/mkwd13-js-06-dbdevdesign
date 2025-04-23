// src/entities/Post.js
import { EntitySchema } from "typeorm";

export const Post = new EntitySchema({
  name: "Post",
  columns: {
    id: {
      primary: true,
      type: "int",
      generated: true,
    },
    title: {
      type: "varchar",
      nullable: false,
    },
    content: {
      type: "text",
      nullable: false,
    },
    createdAt: {
      type: "timestamp",
      createDate: true,
    },
    updatedAt: {
      type: "timestamp",
      updateDate: true,
    },
    authorId: {
      type: "int",
      nullable: false, // or true if posts can be orphaned (post without authorId)
    },
  },
  relations: {
    author: {
      type: "many-to-one",
      target: "User",
      joinColumn: {
        name: "authorId", // tells TypeORM to use the authorId column as the FK
      },
      onDelete: "CASCADE", // if a User is deleted, all their posts are automatically removed
    },
  },
  indices: [
    {
      name: "IDX_POST_AUTHOR",
      columns: ["authorId"],
    },
  ],
});
