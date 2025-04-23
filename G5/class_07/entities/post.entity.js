import { EntitySchema } from 'typeorm';

export const Post = new EntitySchema({
	name: 'posts',
	columns: {
		id: {
			primary: true,
			type: 'int',
			generated: true,
		},
		title: {
			type: 'varchar',
			nullable: false,
		},
		content: {
			type: 'text',
			nullable: true,
		},
		createdAt: {
			type: 'timestamp',
			createDate: true,
		},
		updatedAt: {
			type: 'timestamp',
			updateDate: true,
		},
		authorId: {
			type: 'int',
			nullable: false,
		},
	},
	relations: {
		author: {
			type: 'many-to-one',
			target: 'users',
			joinColumn: {
				name: 'authorId',
			},
			onDelete: 'CASCADE',
		},
	},
});
