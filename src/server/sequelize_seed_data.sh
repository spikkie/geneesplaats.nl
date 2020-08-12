#!/bin/env bash
set -x
set -e

sequelize seed:generate --name User
sequelize seed:generate --name Post
sequelize seed:generate --name Comment
