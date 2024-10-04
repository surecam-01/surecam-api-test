# README

This repository consists of a Ruby on Rails v7 RESTful API that intends to satisfy the requirements outlined in the [Surecam Coding Challenge](https://github.com/surecam-01/surecam-api-test/blob/main/public/default/SureCam-Coding-test.pdf) document.

## POSTGRES DB SETUP COMMANDS
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

`ake permutations:read_input -- file=permutation01.txt` - processes a single file in the `public/permutation_test/*` directory (hint: you can upload additional files to this directory that match the same format)

`rake permutations:generate_random` - generates random string data to determine all permutations

## RAILS SURECAM-API-TEST ROUTES

This RESTful API uses a `TodoClient.rb` to interact with the external [JSON Placeholder TODOs API](https://jsonplaceholder.typicode.com/todos) and then provides basic functionality for creating users who can register, login/logout and then create posts and comment on posts. Respective user interaction histories are provided at the user endpoints.

```
         Prefix Verb     URI Pattern                    Controller#Action
   api_v1_index          /api/v1/index(.:format)        api/v1/api#index {:format=>:json}
api_v1_register GET      /api/v1/register(.:format)     api/v1/users#new {:format=>:json}
                POST     /api/v1/register(.:format)     api/v1/users#create {:format=>:json}
   api_v1_users GET      /api/v1/users(.:format)        api/v1/users#index {:format=>:json}
                GET      /api/v1/users/:id(.:format)    api/v1/users#show {:format=>:json}
                DELETE   /api/v1/users(.:format)        api/v1/users#destroy {:format=>:json}
   api_v1_login GET      /api/v1/login(.:format)        api/v1/sessions#new {:format=>:json}
                POST     /api/v1/login(.:format)        api/v1/sessions#create {:format=>:json}
  api_v1_logout DELETE   /api/v1/logout(.:format)       api/v1/sessions#destroy {:format=>:json}
   api_v1_posts POST     /api/v1/posts(.:format)        api/v1/posts#create {:format=>:json}
                DELETE   /api/v1/posts/:id(.:format)    api/v1/posts#destroy {:format=>:json}
api_v1_comments POST     /api/v1/comments(.:format)     api/v1/comments#create {:format=>:json}
                DELETE   /api/v1/comments/:id(.:format) api/v1/comments#destroy {:format=>:json}
   api_v1_todos GET      /api/v1/todos(.:format)        api/v1/todos#index {:format=>:json}
                PUT|POST /api/v1/todos(.:format)        api/v1/todos#create {:format=>:json}
                DELETE   /api/v1/todos(.:format)        api/v1/todos#destroy {:format=>:json}
```

## POSTMAN COLLECTION

This repository includes a [Postman Collection](https://github.com/surecam-01/surecam-api-test/blob/main/public/default/SURECAM.postman_collection.json) (v2.1.0) with paramterized requests that can be imported through the [Postman API Platform](https://www.postman.com/downloads/) desktop application. This collection enables one to interact seamelessly with the basic surecam-api-test RESTful API functionality.
