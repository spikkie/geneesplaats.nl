"use strict";
module.exports = (sequelize, DataTypes) => {
  var Message = sequelize.define('Message', {
    text: DataTypes.STRING,
    UserId: DataTypes.INTEGER,
    ChatId: DataTypes.INTEGER
  }, {});
  Message.associate = function(models) {
    Message.belongsTo(models.User);
    Message.belongsTo(models.Chat);
  };
  return Message;
};
