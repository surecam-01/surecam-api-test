# README

This repository is to satisfy the requirements in the surecam-api-test

# POSTGRES COMMANDS
```
sudo su - postgres


CREATE USER surecam WITH PASSWORD 'surecam';
ALTER USER surecam CREATEDB;
CREATE DATABASE surecam;


ALTER DATABASE surecam OWNER TO surecam;
GRANT CONNECT ON DATABASE surecam TO surecam;
```
