"use strict";
module.exports = (sequelize, DataTypes) => {
    var Post = sequelize.define(
        "Post",
        {
            text: DataTypes.TEXT,
            UserId: DataTypes.INTEGER
        },
        {}
    );
    Post.associate = function (models) {
        Post.belongsTo(models.User);
    };
    return Post;
};
