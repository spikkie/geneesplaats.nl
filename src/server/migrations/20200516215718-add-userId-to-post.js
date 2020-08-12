"use strict";
module.exports = {
    up: (queryInterface, Sequelize) => {
        return Promise.all([
            queryInterface.addColumn("Posts", "UserId", {
                type: Sequelize.INTEGER
            }),
            queryInterface.addConstraint("Posts", ["UserId"], {
                type: "foreign key",
                name: "fk_user_id",
                references: { table: "Users", field: "id" },
                onDelete: "cascade",
                onUpdate: "cascade"
            })
        ]);
    },
    down: (queryInterface, Sequelize) => {
        return Promise.all([queryInterface.removeColumn("Posts", "UserId")]);
    }
};
