"use strict";
module.exports = {
    up: (queryInterface, Sequelize) => {
        const usersAndChats = Promise.all([
            queryInterface.sequelize.query('SELECT id from "Users";'),
            queryInterface.sequelize.query('SELECT id from "Chats";')
        ]);
        return usersAndChats.then(rows => {
            const users = rows[0][0];
            const chats = rows[1][0];
            return queryInterface.bulkInsert(
                "Messages",
                [
                    {
                        UserId: users[0].id,
                        ChatId: chats[0].id,
                        text: "This is a test message.",
                        createdAt: new Date(),
                        updatedAt: new Date()
                    },
                    {
                        UserId: users[1].id,
                        ChatId: chats[0].id,
                        text: "This is a second test message.",
                        createdAt: new Date(),
                        updatedAt: new Date()
                    },
                    {
                        UserId: users[1].id,
                        ChatId: chats[0].id,
                        text: "This is a third test message.",
                        createdAt: new Date(),
                        updatedAt: new Date()
                    }
                ],
                {}
            );
        });
    },
    down: (queryInterface, Sequelize) => {
        return queryInterface.bulkDelete("Messages", null, {});
    }
};
