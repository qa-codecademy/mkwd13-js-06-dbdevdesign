import { EntitySchema } from "typeorm";

export const User = new EntitySchema({
  name: "User",
  columns: {
    id: {
      primary: true, // marks the column as a primary key
      type: "int",
      generated: true, // tells TypeORM to auto-increment the value on insert
    },
    username: {
      type: "varchar",
      unique: true,
      nullable: false,
    },
    email: {
      type: "varchar",
      unique: true,
      nullable: false,
    },
    password: {
      type: "varchar",
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
  },
  // defines database indexes beyond the unique constraints
  indices: [
    {
      name: "IDX_USER_EMAIL",
      columns: ["email"],
    },
    {
      name: "IDX_USER_USERNAME",
      columns: ["username"],
    },
  ],
  relations: {
    posts: {
      type: "one-to-many",
      target: "Post", // refers to the Post entity schema
      inverseSide: "author", // matches the property on the Post schema that points back to User.
      cascade: false,
    },
  },
});
