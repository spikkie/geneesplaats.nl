import Sequelize from "sequelize";
import configFile from "../config/config";
import models from "../models";

const env = process.env.NODE_ENV || "development";
const config = configFile[env];

let sequelize;
console.log("config.url %0 ", config.url);
if (config.url) {

    sequelize = new Sequelize(config.url, config);
    console.log("sequelize %0 ", sequelize);
} else {
    sequelize = new Sequelize(
        config.database,
        config.username,
        config.password,
        config
    );
}

const db = {
    models: models(sequelize),
    sequelize
};

export default db;
