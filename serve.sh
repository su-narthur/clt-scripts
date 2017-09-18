#!/usr/bin/env bash

(cd /Users/adamjackson/ProgrammingProjects/clt-api; docker-compose down; docker-compose up) &
(cd /Users/adamjackson/ProgrammingProjects/clt-app; docker-compose down; docker-compose up) &