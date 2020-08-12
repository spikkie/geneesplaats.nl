#!/usr/bin/env bash
set -x
set -e

sequelize db:migrate:undo:all
sequelize db:migrate
sequelize db:seed:all

