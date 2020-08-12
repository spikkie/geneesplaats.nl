#!/bin/env bash
set -x
set -e
echo Creating Models and Migrations
echo We need to create the User, Post and Comment models. To do that run the following commands:
sequelize model:generate --name User --attributes name:string,email:string
sequelize model:generate --name Post --attributes title:string,content:text,UserId:integer
sequelize model:generate --name Comment --attributes postId:integer,comment:text,UserId:integer
