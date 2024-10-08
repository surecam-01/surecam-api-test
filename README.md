# README

This repository consists of a Ruby on Rails v7.0 RESTful API that intends to satisfy the requirements outlined in the [Surecam Coding Challenge](https://github.com/surecam-01/surecam-api-test/blob/main/public/default/SureCam-Coding-test.pdf) document.

## POSTGRES DB SETUP COMMANDS
```
$ sudo su - postgres
$ psql

postgres=# CREATE USER surecam WITH PASSWORD 'surecam';
postgres=# ALTER USER surecam CREATEDB;

postgres=# CREATE DATABASE surecam;
postgres=# ALTER DATABASE surecam OWNER TO surecam;

postgres=# GRANT CONNECT ON DATABASE surecam TO surecam;

postgres=# \q
```

## RAILS APP SETUP COMMANDS
```
$ bundle install
$ rake db:create
$ rake db:migrate

-- local server --

$ rails s -b 0.0.0.0

-- app console --

$ rails c

```

## RAILS APP

This RESTful API uses a [client](https://github.com/surecam-01/surecam-api-test/blob/main/app/clients/todo_client.rb) to interact with the external [JSON Placeholder TODOs API](https://jsonplaceholder.typicode.com/todos) and then provides basic functionality for creating users who can register, login/logout and create posts & comments. Stored user interaction histories can be consumed at the `api/v1/user` endpoints.

### ROUTES

```
         Prefix Verb     URI Pattern                    Controller#Action
   api_v1_index          /api/v1/index(.:format)        api/v1/main#index {:format=>:json}
api_v1_register GET      /api/v1/register(.:format)     api/v1/users#new {:format=>:json}
                PUT|POST /api/v1/register(.:format)     api/v1/users#create {:format=>:json}
   api_v1_users GET      /api/v1/users(.:format)        api/v1/users#index {:format=>:json}
         api_v1 GET      /api/v1/users/:id(.:format)    api/v1/users#show {:format=>:json}
                DELETE   /api/v1/users(.:format)        api/v1/users#destroy {:format=>:json}
   api_v1_login GET      /api/v1/login(.:format)        api/v1/sessions#new {:format=>:json}
                PUT|POST /api/v1/login(.:format)        api/v1/sessions#create {:format=>:json}
  api_v1_logout DELETE   /api/v1/logout(.:format)       api/v1/sessions#destroy {:format=>:json}
   api_v1_posts PUT|POST /api/v1/posts(.:format)        api/v1/posts#create {:format=>:json}
                DELETE   /api/v1/posts/:id(.:format)    api/v1/posts#destroy {:format=>:json}
api_v1_comments PUT|POST /api/v1/comments(.:format)     api/v1/comments#create {:format=>:json}
                DELETE   /api/v1/comments/:id(.:format) api/v1/comments#destroy {:format=>:json}
   api_v1_todos GET      /api/v1/todos(.:format)        api/v1/todos#index {:format=>:json}
                PUT|POST /api/v1/todos(.:format)        api/v1/todos#create {:format=>:json}
                DELETE   /api/v1/todos(.:format)        api/v1/todos#destroy {:format=>:json}

```

### INTERACTION MODEL & RULESET

`Posts` and `Comments` are implemented using the `Interaction` object and Single Table Inheritance (STI). Here are the constraints:

* Posts must not have a `:parent_interaction_id`
* A single post can have many comments
* A single post cannot have nested posts
* Comments must have a `:parent_interaction_id`
* Comments can have many nested comments

### PERMUTATION RAKE TASKS

There is a single test file `public/permutation_test/permutation01.txt` provided ([source](https://github.com/surecam-01/surecam-api-test/blob/main/public/permutation_test/permutation01.txt)) which includes the same contents used as the example file in the coding challenge. All `rake tasks` generate respective command-line `stdout` output.

| COMMAND  | Description |
| ------------- | ------------- |
|<sub>`rake permutations:read_all`</sub>| processes all files located in the `public/permutation_test/*` directory |
|<sub>`rake permutations:read_file -- file=permutation01.txt`</sub>| processes a single file that has been uploaded to the `public/permutation_test/*` directory (hint: upload additional files if needed) |
|<sub>`rake permutations:read_random`</sub>| generates random string data to determine all permutations|

## POSTMAN COLLECTION

This repository contains a [Postman Collection](https://github.com/surecam-01/surecam-api-test/blob/main/public/default/SURECAM.postman_collection.json) (v2.1.0) with 18 paramterized requests that can be imported in to the [Postman API Platform](https://www.postman.com/downloads/) desktop application. This collection enables one to interact seamelessly with the basic surecam-api-test RESTful API functionality using a `Bearer <token>` (unless noted). User sessions are also valid for RESTful API interaction without the `Bearer <token>`.
