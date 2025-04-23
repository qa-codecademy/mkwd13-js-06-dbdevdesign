import { EntitySchema } from 'typeorm';

const User = new EntitySchema({
	name: 'users',
	columns: {
		id: {
			type: 'int',
			primary: true,
			generated: true,
		},
		email: {
			type: 'varchar',
			unique: true,
			nullable: false,
		},
		name: {
			type: 'varchar',
			nullable: false,
		},
		createdAt: {
			type: 'timestamp',
			createDate: true,
		},
		updatedAt: {
			type: 'timestamp',
			updateDate: true,
		},
	},
});

export default User;
