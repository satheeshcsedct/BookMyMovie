bookmymovie
======

Application for movie booking

## Setup Instruction

### Software Services Requirements

  * Ruby version `2.7.0`

  You can install using rvm or rbenv.

  * Database mysql

### Dependency Setup

  * Install gem dependency:
```
  bundle install
```

## Configuration
  
  * Modify the mysql database password according to what you given during the mysql setup `database.yml`

## Data Migration

  * Create database
```
  rake db:create
```

  * Run migration and seeding data:
```
  rake db:migrate
  rake seed:migrate
```

## Start Rails server
  * server
```
  rails s
```
  * Your good to access the application in your browser `localhost:4000`