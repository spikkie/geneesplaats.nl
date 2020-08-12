"use strict";

module.exports = {
    up: (queryInterface, Sequelize) => {
        // Get all existing users
        return queryInterface.sequelize
            .query('SELECT id from "Users"')
            .then(busers => {
                const usersRows = busers[0];

                return queryInterface.bulkInsert(
                    "Posts",
                    [
                        {
                            text: "Lorem ipsum 1",
                            UserId: usersRows[0].id,
                            createdAt: new Date(),
                            updatedAt: new Date()
                        },
                        {
                            text: "Lorem ipsum 2",
                            UserId: usersRows[1].id,
                            createdAt: new Date(),
                            updatedAt: new Date()
                        }
                    ],
                    {}
                );
            });
    },
    down: (queryInterface, Sequelize) => {
        return queryInterface.bulkDelete("Posts", null, {});
    }
};
