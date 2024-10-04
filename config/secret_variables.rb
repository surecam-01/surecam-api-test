ENV['RAILS_USER'] = "surecam"
ENV['RAILS_PASS'] = "surecam"
ENV['RAILS_DB']   = "surecam"


# bearer token generated from JWT.encode({:superuser => :password}, ENV['JWT_SECRET'], 'HS256')

ENV['SUPERUSER_BEARER_TOKEN'] = "eyJhbGciOiJIUzI1NiJ9.eyJzdXBlcnVzZXIiOiJwYXNzd29yZCJ9.Sipkv3cegeEZA2vO1Xx3C5bPDIBNcvjWfe8QvRf-hrM"

ENV['JWT_SECRET'] = "746kpAejPb6MGOifT9f3IFJfX700klaJ"
ENV["SECRET_KEY_BASE"] = "26cf9b5930bc8931a843a84e67883f030b66d6f366fa2176d8c1659c2a7d85eb0cfc4857700363784428be15964d9d456d1b8bbc7afeaceed17566346ec5f67d"