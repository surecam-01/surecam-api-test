# README

This repository is to satisfy the requirements in the [Surecam Coding Challenge](https://github.com/surecam-01/surecam-api-test/blob/main/public/SureCam-Coding-test.pdf)

## POSTGRES SETUP COMMANDS
```
sudo su - postgres

CREATE USER surecam WITH PASSWORD 'surecam';
ALTER USER surecam CREATEDB;

CREATE DATABASE surecam;
ALTER DATABASE surecam OWNER TO surecam;

GRANT CONNECT ON DATABASE surecam TO surecam;
```

## PERMUTATION RAKE TASKS

There is a single test file public/permutation_test/permutation01.txt that includes the same contents as the example file. All rake tasks generate respective command-line output

`rake permutations:import_files` - processes all files in the `public/permutation_test/*` directory

`ake permutations:read_input -- file=permutation01.txt` - processes a single file in the `public/permutation_test/*` directory

`rake permutations:generate_random` - generates random string data to determine all permutations

## POSTMAN HELPER

This collection includes a [Postman collection](https://github.com/surecam-01/surecam-api-test/blob/main/public/SURECAM.postman_collection.json) of requests so that one can interact readily with the rails api functionality.
