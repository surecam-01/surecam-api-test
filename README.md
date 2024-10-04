# README

This repository is to satisfy the requirements in the [Surecam Coding Challenge](https://github.com/surecam-01/surecam-api-test/blob/main/public/SureCam-Coding-test.pdf).

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

## RAILS APP ROUTES

```
         Prefix Verb     URI Pattern                    Controller#Action
         api_v1          /api/v1(.:format)              api/v1/api#index {:format=>:json}
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

This repository includes a [Postman Collection](https://github.com/surecam-01/surecam-api-test/blob/main/public/SURECAM.postman_collection.json) (v2.1.0) with requests that can be imported so that one can interact readily with the rails api functionality.
